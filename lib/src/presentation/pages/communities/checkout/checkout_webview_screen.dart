import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/community/payment_outcome.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The page the member pays on. **Payment is not in-app**: the backend makes a
/// Razorpay checkout and this just hosts it.
///
/// Rules that are easy to break (all from the payment guide):
/// * the URL is opened **exactly as returned** and **never reloaded** — its
///   `#t=` token works once and the page strips it, so a reload shows "link
///   not valid". A load failure therefore offers *Close*, not *Retry*.
/// * it is read from [CommunityPurchaseBloc], not passed through the route, so
///   it never lands in a router log.
/// * the app's session cookie never reaches this webview: the API cookie lives
///   in Dio, not in the webview's own store.
/// * the page talks back on a channel named `ReactNativeWebView` — the object
///   its script looks for — carrying `{"type":"payment","status":…}`.
class CheckoutWebViewScreen extends StatefulWidget {
  const CheckoutWebViewScreen({super.key});

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _failed = false;
  bool _reported = false;

  @override
  void initState() {
    super.initState();
    final url = context.read<CommunityPurchaseBloc>().state.checkoutUrl;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppPalette.white)
      ..addJavaScriptChannel(
        'ReactNativeWebView',
        onMessageReceived: _onMessage,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _onNavigate,
          onPageFinished: (_) => setState(() => _loading = false),
          // Main-frame only: a stray sub-resource error must not blank a page
          // that already painted.
          onWebResourceError: (e) {
            if (e.isForMainFrame ?? true) {
              setState(() => _failed = true);
            }
          },
        ),
      );
    if (url == null || url.isEmpty) {
      _failed = true;
    } else {
      _controller.loadRequest(Uri.parse(url));
    }
  }

  /// UPI apps (`upi://`, `gpay://`, `phonepe://`, `intent://`…) are handed to
  /// the system, as Razorpay's UPI flow needs; web pages stay in the webview.
  NavigationDecision _onNavigate(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    const inApp = {'http', 'https', 'about', 'data', 'blob', 'javascript'};
    if (uri == null || inApp.contains(uri.scheme)) {
      return NavigationDecision.navigate;
    }
    launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    ).catchError((_) => false);
    return NavigationDecision.prevent;
  }

  void _onMessage(JavaScriptMessage message) {
    final outcome = PaymentOutcome.parse(message.message);
    if (outcome == null || !mounted) return;
    final bloc = context.read<CommunityPurchaseBloc>();
    bloc.add(CommunityPurchaseEvent.paymentReported(outcome));
    // `closed` is only Razorpay's popup being dismissed; the page stays on
    // its Pay button, so keep the webview.
    if (outcome == PaymentOutcome.closed) return;
    _reported = true;
    // Swap this page for the confirmation screen so Back never returns here.
    context.pushReplacement(AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_PATH);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        // Left without the page saying anything — they may still have paid.
        if (didPop && !_reported) {
          context.read<CommunityPurchaseBloc>().add(
            const CommunityPurchaseEvent.checkoutDismissed(),
          );
        }
      },
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(title: const Text('Secure payment')),
        body: SafeArea(
          child: _failed
              ? _LoadFailed(onClose: () => context.pop())
              : Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (_loading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
        ),
      ),
    );
  }
}

class _LoadFailed extends StatelessWidget {
  const _LoadFailed({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    return Center(
      child: Padding(
        padding: AppSpacing.screen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "We couldn't open the payment page. Nothing was charged. "
              'Close this and tap Buy again.',
              textAlign: TextAlign.center,
              style: type.description,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(onPressed: onClose, child: const Text('Close')),
          ],
        ),
      ),
    );
  }
}
