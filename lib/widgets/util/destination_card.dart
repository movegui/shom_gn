import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/responsive.dart';

class DestinationCard extends StatelessWidget {
  final String city;
  final String? country;
  final String imageUrl;
  final double price;
  final VoidCallback? onTap;
  final Color? color;

  const DestinationCard({
    super.key,
    required this.city,
    this.country,
    required this.imageUrl,
    required this.price,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        //    width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: Responsive.isDesktop(context) ? 180 : 120,
                width: double.infinity,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(width: 6),
                      Text(
                        city,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color ?? AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "À partir de ${price.toStringAsFixed(0)} €",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
