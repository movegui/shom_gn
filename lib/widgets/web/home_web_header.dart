import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';

class HomeWebHeader extends StatelessWidget {
  const HomeWebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            "SHOM-GN",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 60),

          const Text("Accueil"),
          const SizedBox(width: 30),

          const Text("Vols"),
          const SizedBox(width: 30),

          const Text("Hôtels"),
          const SizedBox(width: 30),

          const Text("Mes voyages"),

          const Spacer(),

          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),

          const CircleAvatar(
            radius: 20,
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}