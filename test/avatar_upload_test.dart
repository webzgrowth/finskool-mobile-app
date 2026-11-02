import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/data/datasource/auth_remote_datasource.dart';
import 'package:finskool/src/data/repository/auth_repository_impl.dart';
import 'package:finskool/src/domain/model/auth/avatar_upload_link.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Stands in for the *storage host*: a real HTTP server the signed link points
/// at, so the PUT — its bytes, content type and, above all, the headers it
/// does **not** carry — is exercised on the real client.
class _Storage {
  late final HttpServer http;
  final headers = <HttpHeaders>[];
  final bodies = <List<int>>[];
  int status = 200;

  Future<void> start() async {
    http = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    http.listen((request) async {
      headers.add(request.headers);
      bodies.add(await request.fold<List<int>>([], (a, b) => a..addAll(b)));
      request.response.statusCode = status;
      await request.response.close();
    });
  }

  String get url => 'http://127.0.0.1:${http.port}/avatars/abc.jpg?X-Amz=1';
}

/// Records the two calls our API sees; nothing else in the datasource runs.
class _Remote extends AuthRemoteDatasource {
  _Remote(this.storage) : super(ApiClient());

  final _Storage storage;
  final calls = <String>[];
  String? requestedFilename;
  String? savedUrl;

  @override
  Future<AvatarUploadLink> avatarUploadLink(String filename) async {
    calls.add('link');
    requestedFilename = filename;
    return AvatarUploadLink(
      uploadUrl: storage.url,
      publicUrl: 'https://cdn.example/avatars/abc.jpg',
    );
  }

  @override
  Future<UserModel> saveAvatar(String publicUrl) async {
    calls.add('save');
    savedUrl = publicUrl;
    // The server's user has no `memberSince`: only the picture may be taken.
    return const UserModel(
      id: 'u1',
      name: 'Server Name',
      phone: '+91',
      email: 'server@x.com',
      role: 'member',
      isSuperAdmin: false,
      postNotificationsEnabled: true,
      avatarUrl: 'https://cdn.example/avatars/abc.jpg',
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Storage storage;
  late _Remote remote;
  late AuthRepositoryImpl repo;
  late Directory tmp;

  File picture(String name, {int bytes = 2000}) {
    final f = File('${tmp.path}/$name')
      ..writeAsBytesSync(List.filled(bytes, 7));
    return f;
  }

  setUp(() async {
    // flutter_test blocks real HTTP by default; this server is on localhost.
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    await SharedPreferenceHelper().storedata(
      StorageKeys.cachedUser,
      jsonEncode(
        UserModel(
          id: 'u1',
          name: 'Local Name',
          phone: '+911',
          email: 'local@x.com',
          role: 'member',
          isSuperAdmin: false,
          postNotificationsEnabled: true,
          memberSince: DateTime(2026, 5, 1),
        ).toJson(),
      ),
    );
    storage = _Storage();
    await storage.start();
    remote = _Remote(storage);
    repo = AuthRepositoryImpl(remote);
    tmp = await Directory.systemTemp.createTemp('avatar_test');
  });

  tearDown(() async {
    await storage.http.close(force: true);
    await tmp.delete(recursive: true);
  });

  test('uploads in order and keeps everything but the picture', () async {
    final result = await repo.updateAvatar(picture('me.jpg').path);
    final user = result.getOrElse(() => throw 'failed');

    expect(remote.calls, ['link', 'save']);
    expect(remote.requestedFilename, 'me.jpg');
    expect(remote.savedUrl, 'https://cdn.example/avatars/abc.jpg');
    expect(storage.bodies.single, hasLength(2000));
    expect(user.avatarUrl, 'https://cdn.example/avatars/abc.jpg');
    // The local-only edits and the join date survive: only the picture is taken.
    expect(user.name, 'Local Name');
    expect(user.memberSince, DateTime(2026, 5, 1));
    // …and it is cached, so a restart still shows it.
    expect(repo.cachedUser?.avatarUrl, 'https://cdn.example/avatars/abc.jpg');
  });

  test(
    'the PUT is raw bytes with the right type and NEVER our credential',
    () async {
      await SharedPreferenceHelper().storedata(
        StorageKeys.sessionCookie,
        'secret',
      );
      await repo.updateAvatar(picture('me.png').path);
      final h = storage.headers.single;
      expect(h.contentType?.mimeType, 'image/png');
      expect(h.contentLength, 2000);
      expect(h.value('cookie'), isNull);
      expect(h.value('authorization'), isNull);
    },
  );

  test('the filename carries the real extension', () async {
    await repo.updateAvatar(picture('photo.WEBP').path);
    expect(remote.requestedFilename, 'me.webp');
    expect(storage.headers.single.contentType?.mimeType, 'image/webp');
  });

  test('if the upload fails the picture is NOT saved on the account', () async {
    storage.status = 403;
    final result = await repo.updateAvatar(picture('me.jpg').path);
    expect(result.isLeft(), isTrue);
    expect(remote.calls, ['link']); // never reached "save"
    expect(repo.cachedUser?.avatarUrl, isNull);
  });

  test(
    'a wrong type or an oversized file is refused before any request',
    () async {
      final gif = await repo.updateAvatar(picture('me.gif').path);
      final big = await repo.updateAvatar(
        picture('big.jpg', bytes: 5 * 1024 * 1024 + 1).path,
      );
      expect(gif.isLeft(), isTrue);
      expect(big.isLeft(), isTrue);
      expect(remote.calls, isEmpty);
      final message = gif.fold((f) => f.message, (_) => '');
      expect(message, contains('JPG, PNG or WebP'));
    },
  );

  test('the avatar link parses and the model keeps unrelated fields', () {
    final link = AvatarUploadLink.fromJson({
      'uploadUrl': 'u',
      'publicUrl': 'p',
    });
    expect([link.uploadUrl, link.publicUrl], ['u', 'p']);
  });
}
