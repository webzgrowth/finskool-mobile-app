import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/api/api_client.dart';

/// A real HTTP server standing in for the storage host the signed invoice
/// link points at, so the GET — its bytes, status handling and the headers it
/// does **not** carry — runs on the real client.
class _Storage {
  late final HttpServer http;
  final headers = <HttpHeaders>[];
  int status = 200;
  List<int> body = const [37, 80, 68, 70, 45];

  Future<void> start() async {
    http = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    http.listen((request) async {
      headers.add(request.headers);
      request.response.statusCode = status;
      request.response.add(body);
      await request.response.close();
    });
  }

  String get url => 'http://127.0.0.1:${http.port}/invoices/a.pdf?sig=1';
}

void main() {
  late _Storage storage;

  setUp(() async {
    HttpOverrides.global = null;
    storage = _Storage();
    await storage.start();
    addTearDown(() => storage.http.close(force: true));
  });

  test('returns the file bytes', () async {
    final bytes = await ApiClient.downloadBytes(storage.url);
    expect(bytes, [37, 80, 68, 70, 45]);
  });

  test(
    'sends no session cookie or Authorization to the storage host',
    () async {
      await ApiClient.downloadBytes(storage.url);
      final sent = storage.headers.single;
      expect(sent.value(HttpHeaders.cookieHeader), isNull);
      expect(sent.value(HttpHeaders.authorizationHeader), isNull);
    },
  );

  test(
    'an expired or refused link throws instead of saving an error page',
    () async {
      storage
        ..status = 403
        ..body = '<Error>expired</Error>'.codeUnits;
      expect(ApiClient.downloadBytes(storage.url), throwsA(anything));
    },
  );

  test('an empty body is an error, not an empty PDF', () async {
    storage.body = const [];
    expect(ApiClient.downloadBytes(storage.url), throwsA(anything));
  });
}
