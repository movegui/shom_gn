import 'package:flutter/material.dart';
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/widgets/address/default_address_widget.dart';
import 'package:shom_gn/widgets/address/default_selection_widget.dart';


class DefaultStoreOrPositionAddressWidget extends StatelessWidget {
  final AddressModel? model;
  final String? defaultId;
  final ValueChanged<String?> onDefaultChange;
  final String? title;
  final String? locationTitle;

  const DefaultStoreOrPositionAddressWidget({
    super.key,
    required this.model,
    required this.defaultId,
    required this.onDefaultChange,
    this.title,
    this.locationTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20, child: Icon(Icons.location_on)),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    locationTitle ?? 'Location',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (model?.id == defaultId) DefaultAddressWidget(),
              ],
            ),
            const SizedBox(height: 4),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.address ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  model?.district ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                DefaultSelectionWidget(
                  defaultId: defaultId,
                  onDefaultChange: (String? value) {
                    onDefaultChange.call(value);
                  },
                  selectedId: model?.id ?? '',
                  title: title,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
