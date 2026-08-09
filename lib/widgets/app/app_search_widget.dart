import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/input/input_widget.dart';

class AppSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String? hintText;

  const AppSearchWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onClear,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: InputWidget(
        controller: controller,
        focusNode: focusNode,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(icon: const Icon(Icons.close), onPressed: onClear)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
         hintText: hintText ?? AppLocalizations.of(context)!.search,
      ),

    );
  }
}
