import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/presentation/bloc/services/payment/service_payment_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'quote_card.dart';

/// Asks for the invoice's billing details, then pops them as a
/// [BillingDetails]. The state drives the GST split on the invoice (CGST +
/// SGST within the supplier's state, IGST outside), so it is required; GSTIN
/// and address are optional but validated when given.
///
/// [initial] pre-fills from the details last paid with; [errors] is the
/// server's per-field complaint after a 422 (the sheet is reopened with it,
/// since the member can only fix a field they can see).
Future<BillingDetails?> showBillingSheet(
  BuildContext context, {
  required ServiceQuoteModel quote,
  required String initialName,
  BillingDetails? initial,
  Map<String, String> errors = const {},
}) {
  final payment = context.read<ServicePaymentBloc>()
    ..add(const ServicePaymentEvent.statesRequested());
  return showModalBottomSheet<BillingDetails>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: payment,
      child: _BillingSheet(
        quote: quote,
        initialName: initialName,
        initial: initial,
        errors: errors,
      ),
    ),
  );
}

class _BillingSheet extends StatefulWidget {
  const _BillingSheet({
    required this.quote,
    required this.initialName,
    required this.initial,
    required this.errors,
  });

  final ServiceQuoteModel quote;
  final String initialName;
  final BillingDetails? initial;
  final Map<String, String> errors;

  @override
  State<_BillingSheet> createState() => _BillingSheetState();
}

class _BillingSheetState extends State<_BillingSheet> {
  late final _name = TextEditingController(
    text: widget.initial?.name ?? widget.initialName,
  );
  late final _gstin = TextEditingController(text: widget.initial?.gstin ?? '');
  late final _address = TextEditingController(
    text: widget.initial?.address ?? '',
  );
  late String? _stateCode = widget.initial?.stateCode;
  late Map<String, String> _errors = {...widget.errors};

  @override
  void dispose() {
    _name.dispose();
    _gstin.dispose();
    _address.dispose();
    super.dispose();
  }

  void _submit() {
    final errors = <String, String>{};
    if (_name.text.trim().isEmpty) errors['name'] = 'Enter the billing name.';
    if (_stateCode == null) errors['state'] = 'Choose your state.';
    final gstin = _gstin.text.trim().toUpperCase();
    if (gstin.isNotEmpty) {
      if (!RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z][A-Z\d]Z[A-Z\d]$')
          .hasMatch(gstin)) {
        errors['gstin'] = 'Enter a valid 15-character GSTIN.';
      } else if (_stateCode != null && !gstin.startsWith(_stateCode!)) {
        // A GSTIN's first two digits *are* its state's GST code.
        errors['gstin'] = "The GSTIN's first two digits must match the state.";
      }
    }
    setState(() => _errors = errors);
    if (errors.isNotEmpty) return;
    Navigator.pop(
      context,
      BillingDetails(
        name: _name.text.trim(),
        stateCode: _stateCode!,
        gstin: gstin,
        address: _address.text.trim(),
      ),
    );
  }

  /// The limits are enforced; a "0/150" counter on every field is just noise.
  static Widget? _noCounter(
    BuildContext _, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) => null;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final states = context.select<ServicePaymentBloc, List<GstState>>(
      (b) => b.state.states,
    );
    final loading = context.select<ServicePaymentBloc, bool>(
      (b) => b.state.statesLoad.isLoading,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.paddingOf(context).bottom,
        ),
        decoration: const BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Billing details', style: type.headerTitle),
              const SizedBox(height: 4),
              Text(
                'These appear on your tax invoice.',
                style: type.headerSubtitle,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                maxLength: 150,
                buildCounter: _noCounter,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: _errors['name'],
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                // Rebuilt when the list arrives, so a remembered state shows
                // up; a code not in the list would trip the dropdown's assert.
                key: ValueKey(states.length),
                initialValue: states.any((s) => s.code == _stateCode)
                    ? _stateCode
                    : null,
                isExpanded: true,
                hint: Text(loading ? 'Loading states…' : 'State'),
                decoration: InputDecoration(
                  labelText: 'State',
                  errorText: _errors['state'],
                ),
                items: [
                  for (final s in states)
                    DropdownMenuItem(value: s.code, child: Text(s.name)),
                ],
                onChanged: (v) => setState(() => _stateCode = v),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _gstin,
                textCapitalization: TextCapitalization.characters,
                maxLength: 15,
                buildCounter: _noCounter,
                decoration: InputDecoration(
                  labelText: 'GSTIN (optional)',
                  errorText: _errors['gstin'],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _address,
                maxLines: 2,
                maxLength: 300,
                buildCounter: _noCounter,
                decoration: InputDecoration(
                  labelText: 'Address (optional)',
                  errorText: _errors['address'],
                ),
              ),
              const SizedBox(height: 18),
              TicketButton(
                label: 'Pay ${rupees(widget.quote.totalAmount)}',
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
