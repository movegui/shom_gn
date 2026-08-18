import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class DestinationCard extends StatelessWidget {
  final String city;
  final String? country;
  final String imageUrl;
  final double price;
  final VoidCallback? onTap;

  const DestinationCard({
    super.key,
    required this.city,
    this.country,
    required this.imageUrl,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
    //    width: double.infinity,
        height: 00,
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
                height: 150,
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
                      SizedBox(width: 6,),
                      Text(
                        city,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
