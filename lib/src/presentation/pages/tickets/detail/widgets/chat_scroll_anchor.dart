import 'package:flutter/widgets.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';

/// Keeps a chat list where the member expects it as messages come and go.
///
/// * first messages arrive -> land on the **latest** one;
/// * a message is added -> follow it, but only if the member was already near
///   the bottom (or sent it) — never yank someone who is reading history;
/// * older messages are prepended -> shift by exactly what was added, so the
///   message they were reading stays put.
class ChatScrollAnchor {
  ChatScrollAnchor(this.controller, {required this.isMounted});

  final ScrollController controller;
  final bool Function() isMounted;

  TicketChatState? _last;

  /// `maxScrollExtent` when an "earlier messages" fetch began.
  double _extentBeforePrepend = 0;

  static const double _nearBottom = 200;

  void _afterFrame(VoidCallback action) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isMounted() && controller.hasClients) action();
      });

  void onState(TicketChatState s) {
    final last = _last;
    _last = s;
    if (last == null) return;

    if (!last.isLoadingEarlier && s.isLoadingEarlier && controller.hasClients) {
      _extentBeforePrepend = controller.position.maxScrollExtent;
    }
    if (last.isLoadingEarlier && !s.isLoadingEarlier) {
      _afterFrame(() {
        final added =
            controller.position.maxScrollExtent - _extentBeforePrepend;
        controller.jumpTo(controller.position.pixels + added);
      });
      return;
    }

    final firstLoad = last.messages.isEmpty && s.messages.isNotEmpty;
    final grew = s.messages.length > last.messages.length;
    if (firstLoad) {
      _afterFrame(() => controller.jumpTo(controller.position.maxScrollExtent));
    } else if (grew) {
      final mine = s.messages.last.isMine;
      final near =
          controller.hasClients &&
          controller.position.extentAfter < _nearBottom;
      if (mine || near) {
        _afterFrame(
          () => controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
        );
      }
    }
  }
}
