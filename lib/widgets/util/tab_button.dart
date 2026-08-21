import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class TabButton extends StatelessWidget {
  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  const TabButton({
    super.key,
    required this.child,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //: AppColors.backgroundColor,
        decoration: BoxDecoration(
          color: selected ? AppColors.selectionColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
          child: child,
        ),
      ),
    );
  }
}