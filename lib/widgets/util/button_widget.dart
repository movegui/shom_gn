import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/models/button_info.dart';

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
            return AppColors.selectionColor; // hover color
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.selectionColor;
          }
          return buttonStyle?.backgroundColor?.resolve({}) ??
              AppColors.disabled;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primary;
          }
          return buttonStyle?.foregroundColor?.resolve({}) ??
              AppColors.disabled;
        }),
      ),
      icon: icon ?? const SizedBox(),
      label: Text(buttonItem.title ?? '', style: textStyle),
      onPressed: () async {
        await onPressed(buttonItem);
      },
    );
  }
}
