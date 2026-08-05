import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';

class ButtonValidationWidgetOld extends StatelessWidget {
  final String title;
  final Future<void> Function() onPress;
  final Icon? icon;

  const ButtonValidationWidgetOld({
    super.key,
    required this.title,
    required this.onPress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12.0),
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        icon: icon,
        label: Text(
          title,
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 28,
          ),
        ),
        onPressed: onPress, // ✅ simplest and correct
      ),
    );
  }
}