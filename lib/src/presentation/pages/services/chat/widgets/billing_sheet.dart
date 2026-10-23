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
Future<BillingDetails?> showBillingSheet(
  BuildContext context, {
  required ServiceQuoteModel quote,
  required String initialName,
}) {
  final payment = context.read<ServicePaymentBloc>()
    ..add(const ServicePaymentEvent.statesRequested());
  return showModalBottomSheet<BillingDetails>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: payment,
      child: _BillingSheet(quote: quote, initialName: initialName),
    ),
  );
}

class _BillingSheet extends StatefulWidget {
  const _BillingSheet({required this.quote, required this.initialName});

  final ServiceQuoteModel quote;
  final String initialName;

  @override
  State<_BillingSheet> createState() => _BillingSheetState();
}

class _BillingSheetState extends State<_BillingSheet> {
  late final _name = TextEditingController(text: widget.initialName);
  final _gstin = TextEditingController();
  final _address = TextEditingController();
  String? _stateCode;
  Map<String, String> _errors = {};

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
    if (gstin.isNotEmpty &&
        !RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z][A-Z\d]Z[A-Z\d]$').hasMatch(gstin)) {
      errors['gstin'] = 'Enter a valid 15-character GSTIN.';
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
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: _errors['name'],
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _stateCode,
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
                decoration: InputDecoration(
                  labelText: 'GSTIN (optional)',
                  errorText: _errors['gstin'],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _address,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address (optional)',
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
