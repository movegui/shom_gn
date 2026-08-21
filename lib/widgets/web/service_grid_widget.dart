import 'package:flutter/material.dart';
import 'package:shom_gn/widgets/web/service_card_widget.dart';

class ServiceGridWidget extends StatelessWidget {
  const ServiceGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: const [
          ServiceCard(
            title: "Vols",
            icon: Icons.flight,
          ),
          ServiceCard(
            title: "Hôtels",
            icon: Icons.hotel,
          ),
          ServiceCard(
            title: "Restaurant",
            icon: Icons.restaurant,
          ),
          ServiceCard(
            title: "Pressing",
            icon: Icons.local_laundry_service,
          ),
        ],
      ),
    );
  }
}
