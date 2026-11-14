import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/bloc/transactions/list/transactions_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/transaction_card.dart';
import 'widgets/transaction_invoice.dart';
import 'widgets/transactions_skeleton.dart';

/// Profile → Transaction history. Figma: Final page,
/// `Profile / Transaction History – V1` (`1809:5414`) — the My Tickets chrome (a
/// short teal hero, a white sheet) with a card per payment.
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              locator<TransactionsBloc>()..add(const TransactionsEvent.load()),
        ),
        // Route-scoped: it briefly holds an invoice's bytes.
        BlocProvider(create: (_) => locator<InvoiceDownloadBloc>()),
      ],
      child: const TransactionsView(),
    );
  }
}

/// The screen minus its blocs, public so a test can supply ready ones.
class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InvoiceSaveListener(
      child: BlocConsumer<TransactionsBloc, TransactionsState>(
        // A failed refresh keeps the rows and says why.
        listenWhen: (a, b) =>
            b.message.isNotEmpty &&
            a.message != b.message &&
            b.transactions.isNotEmpty,
        listener: (context, state) => AppSnack.show(state.message),
        builder: (context, state) => TicketSheetPage(
          header: TicketHeader(
            spec: TicketHeaderSpec.transactions,
            title: 'Transaction history',
            subtitle: 'Your past payments and invoices',
            onBack: () => context.pop(),
          ),
          body: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TransactionsState state) {
    if (state.state.isLoading || state.state.isEmpty) {
      return const Shimmer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              TransactionCardSkeleton(),
              SizedBox(height: 12),
              TransactionCardSkeleton(),
              SizedBox(height: 12),
              TransactionCardSkeleton(),
            ],
          ),
        ),
      );
    }
    if (state.state.isError) {
      return _Message(
        text: state.message,
        action: 'Try again',
        onAction: () => context.read<TransactionsBloc>().add(
          const TransactionsEvent.load(),
        ),
      );
    }
    if (state.transactions.isEmpty) {
      return const _Message(text: 'You have no payments yet.');
    }
    return _List(state: state);
  }
}

class _List extends StatefulWidget {
  const _List({required this.state});

  final TransactionsState state;

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  /// The row whose Download was tapped last — only that one shows a spinner.
  String? _active;

  /// Asks for the next page when the end is near. `maxScrollExtent > 0` keeps a
  /// list that does not scroll from asking on every notification; the bloc
  /// repeats the `hasMore` / in-flight guard.
  bool _onScroll(ScrollNotification n) {
    final s = widget.state;
    if (n.metrics.maxScrollExtent > 0 &&
        n.metrics.extentAfter < 600 &&
        s.hasMore &&
        !s.isLoadingMore) {
      context.read<TransactionsBloc>().add(const TransactionsEvent.loadMore());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final busy = context.watch<InvoiceDownloadBloc>().state.state.isLoading;
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<TransactionsBloc>()
          ..add(const TransactionsEvent.refresh());
        await bloc.stream.firstWhere((s) => !s.isRefreshing);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView(
          // The header is 69 tall, which already holds Figma's 22 above the
          // first card; the footnote sits 12 under the last one.
          padding: EdgeInsets.fromLTRB(20, 0, 20, 24 + bottom),
          children: [
            for (final t in s.transactions) ...[
              TransactionCard(
                key: ValueKey(t.id),
                transaction: t,
                downloading: busy && _active == t.id,
                onTap: () =>
                    context.push(AppRoutes.transactionDetail(t.id), extra: t),
                onDownload: () {
                  setState(() => _active = t.id);
                  requestInvoice(context, t);
                },
              ),
              const SizedBox(height: 12),
            ],
            if (s.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else if (!s.hasMore)
              Text(
                'Invoices are also sent to your registered email.',
                textAlign: TextAlign.center,
                style: context.transactionType.footnote,
              ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.action, this.onAction});

  final String text;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: context.ticketType.emptyBody,
            ),
            if (action != null) ...[
              const SizedBox(height: 12),
              TextButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
