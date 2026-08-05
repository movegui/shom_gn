

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movegui/services/assets_manager.dart';

class ImageBanner extends StatelessWidget {
  final List<String> images = [
    AssetsManager.pressing1Image,
   AssetsManager.pressing2Image,
   AssetsManager.pressing3Image,
  ];

  const ImageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: images.map((image) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }
}