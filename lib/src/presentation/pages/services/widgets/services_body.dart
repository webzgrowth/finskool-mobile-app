import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/presentation/bloc/services/catalog/services_catalog_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/filter/services_filter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'service_card_skeleton.dart';

/// The Services tab's list slivers: loading, error + retry, empty, or the
/// filtered cards. Two blocs, combined here in the widget layer.
class ServicesBody extends StatelessWidget {
  const ServicesBody({super.key, required this.builder});

  final Widget Function(ServiceModel service) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesFilterBloc, ServicesFilterState>(
      builder: (context, filter) =>
          BlocBuilder<ServicesCatalogBloc, ServicesCatalogState>(
            builder: (context, state) {
              if (state.state.isLoading || state.state.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Shimmer(
                    child: Column(
                      children: [
                        ServiceCardSkeleton(),
                        ServiceCardSkeleton(),
                        ServiceCardSkeleton(),
                      ],
                    ),
                  ),
                );
              }
              if (state.state.isError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _Message(
                    text: state.message,
                    action: TextButton(
                      onPressed: () => context.read<ServicesCatalogBloc>().add(
                        const ServicesCatalogEvent.refresh(),
                      ),
                      child: const Text('Try again'),
                    ),
                  ),
                );
              }
              final q = filter.query.trim().toLowerCase();
              final shown = q.isEmpty
                  ? state.services
                  : state.services
                        .where(
                          (s) =>
                              s.title.toLowerCase().contains(q) ||
                              s.description.toLowerCase().contains(q),
                        )
                        .toList();
              if (shown.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _Message(
                    text: q.isEmpty
                        ? 'No services are available right now.'
                        : 'No services match that search.',
                  ),
                );
              }
              return SliverList.builder(
                itemCount: shown.length,
                itemBuilder: (context, i) => builder(shown[i]),
              );
            },
          ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.communityType.description,
          ),
          ?action,
        ],
      ),
    ),
  );
}
