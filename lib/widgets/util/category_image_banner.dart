
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';


class CategoryImageBanner extends StatelessWidget {
  const CategoryImageBanner({super.key});


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: AppConstants.allCategoriesItems(AppLocalizations.of(context)!,).map((categoryItem) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            categoryItem.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }
}