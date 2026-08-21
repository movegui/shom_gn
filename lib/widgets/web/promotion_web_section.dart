import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class PromotionWebSection extends StatelessWidget {
  const PromotionWebSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1200,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Offres spéciales",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "-20% sur vos prochains vols",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            child: Text("Voir les offres"),
          )
        ],
      ),
    );
  }
}