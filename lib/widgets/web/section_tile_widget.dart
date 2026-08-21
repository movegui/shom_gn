import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class SectionTileWidget extends StatelessWidget {
  final String title;

  const SectionTileWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.secondary, // Or / Gold
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}