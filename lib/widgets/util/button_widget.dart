import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonInfo buttonItem;
  final Widget? icon;
  final Future<void> Function(ButtonInfo item) onPressed;
  final TextStyle? textStyle;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = Theme.of(context).elevatedButtonTheme.style;
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(8.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return buttonItem.enabled
                ? AppColors.selectionColor
                : AppColors.disabled; // hover color
          }
          if (states.contains(WidgetState.pressed)) {
            return buttonItem.enabled
                ? AppColors.selectionColor
                : AppColors.disabled;
          }
          return buttonItem.enabled
              ? (buttonStyle?.backgroundColor?.resolve({}) ??
                    AppColors.disabled)
              : AppColors.disabled;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return buttonItem.enabled ? AppColors.primary : AppColors.disabled;
          }
          return buttonItem.enabled
              ? (buttonStyle?.backgroundColor?.resolve({}) ??
                    AppColors.disabled)
              : AppColors.disabled;
        }),
      ),
      icon: icon ?? const SizedBox(),
      label: Text(buttonItem.title ?? '', style: textStyle),
      onPressed: () async {
        if (buttonItem.enabled) {
          await onPressed(buttonItem);
        } else {
          MessageWidget.errorMessage(
            context,
            AppLocalizations.of(context)!.deactivate_button_title,
            AppLocalizations.of(context)!.deactivate_button_message,
            Icon(Icons.error, color: AppColors.error),
            FlushbarPosition.TOP,
          );
        }
      },
    );
  }
}
