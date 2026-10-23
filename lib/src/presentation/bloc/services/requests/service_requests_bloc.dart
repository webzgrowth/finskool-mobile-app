import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/usecases/services/get_service_requests.dart';

part 'service_requests_event.dart';
part 'service_requests_state.dart';
part 'service_requests_bloc.freezed.dart';

/// "My requests": the member's service requests, newest activity first.
///
/// Route-scoped (`@injectable`). A push for a request already in the list is
/// **merged into its row** (and the row moves to the top); a push for one the
/// list doesn't know — a request raised on another device — triggers a
/// refresh, because a socket `Summary` lacks the fields a row needs.
@injectable
class ServiceRequestsBloc
    extends Bloc<ServiceRequestsEvent, ServiceRequestsState> {
  ServiceRequestsBloc(this._getRequests, this._socket)
    : super(ServiceRequestsState.initial()) {
    on<ServiceRequestsEvent>((event, emit) async {
      await event.map(
        load: (_) => _load(emit),
        loadMore: (_) => _loadMore(emit),
        pushed: (e) => _onPush(e.event, emit),
        reconnected: (_) => _load(emit, quiet: true),
      );
    });
    _sub = _socket.events.listen((e) {
      if (e.event.startsWith('service.')) add(ServiceRequestsEvent.pushed(e));
    });
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline) {
        add(const ServiceRequestsEvent.reconnected());
      }
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetServiceRequests _getRequests;
  final TicketsSocket _socket;
  StreamSubscription<SocketEvent>? _sub;
  StreamSubscription<SocketStatus>? _statusSub;
  bool _wasOffline = false;

  Future<void> _load(
    Emitter<ServiceRequestsState> emit, {
    bool quiet = false,
  }) async {
    if (!quiet && state.requests.isEmpty) {
      emit(state.copyWith(state: RequestState.loading, message: ''));
    }
    final result = await _getRequests.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(
          state: state.requests.isEmpty
              ? RequestState.error
              : RequestState.loaded,
          message: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          state: RequestState.loaded,
          requests: page.items,
          cursor: page.nextCursor,
          message: '',
        ),
      ),
    );
  }

  Future<void> _loadMore(Emitter<ServiceRequestsState> emit) async {
    if (state.cursor == null || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getRequests.execute(cursor: state.cursor);
    result.fold(
      (f) => emit(state.copyWith(isLoadingMore: false, message: f.message)),
      (page) {
        final known = state.requests.map((r) => r.id).toSet();
        emit(
          state.copyWith(
            isLoadingMore: false,
            requests: [
              ...state.requests,
              ...page.items.where((r) => !known.contains(r.id)),
            ],
            cursor: page.nextCursor,
          ),
        );
      },
    );
  }

  Future<void> _onPush(
    SocketEvent e,
    Emitter<ServiceRequestsState> emit,
  ) async {
    final summary = e.data['request'];
    if (summary is! Map<String, dynamic>) return;
    final id = summary['id'] as String?;
    final index = state.requests.indexWhere((r) => r.id == id);
    if (index == -1) {
      await _load(emit, quiet: true);
      return;
    }
    final next = [...state.requests];
    next[index] = next[index].mergedWithSummary(summary);
    next.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    emit(state.copyWith(requests: next));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
