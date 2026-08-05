import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';


class DefaultSelectionWidget extends StatelessWidget {
  final String? selectedId;
  final String? defaultId;
  final ValueChanged<String?> onDefaultChange;
  final String? title;

  const DefaultSelectionWidget({
    super.key,
    required this.selectedId,
    required this.defaultId,
    required this.onDefaultChange,
    this.title
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
           title ?? AppLocalizations.of(context)!.standard_address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Radio<String>(
            value: selectedId ?? '',
            groupValue: defaultId,
            onChanged: (value) {
              onDefaultChange.call(value);
            },
          ),
        ),
      ],
    );
  }
}
