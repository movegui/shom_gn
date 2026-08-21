import 'package:flutter/material.dart';
import 'package:shom_gn/responsive.dart';

class AppWebBannerWidget extends StatelessWidget {
  const AppWebBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =  Responsive.isMobile(context); // MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/banners/banner1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.45),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Pourquoi choisir SHOM ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 50),

          isMobile
              ? Column(
                  children: const [
                    _FeatureCard(
                      icon: Icons.flight_takeoff,
                      title: "Réservation simplifiée",
                      description:
                          "Réservez vos vols rapidement avec une expérience fluide et intuitive.",
                    ),
                    SizedBox(height: 40),
                    _FeatureCard(
                      icon: Icons.notifications_active,
                      title: "Alertes en temps réel",
                      description:
                          "Recevez immédiatement les mises à jour importantes concernant vos voyages.",
                    ),
                    SizedBox(height: 40),
                    _FeatureCard(
                      icon: Icons.travel_explore,
                      title: "Plus de destinations",
                      description:
                          "Accédez à un large catalogue de destinations et compagnies aériennes.",
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.flight_takeoff,
                        title: "Réservation simplifiée",
                        description:
                            "Réservez vos vols rapidement avec une expérience fluide et intuitive.",
                      ),
                    ),

                    SizedBox(width: 40),

                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.notifications_active,
                        title: "Alertes en temps réel",
                        description:
                            "Recevez immédiatement les mises à jour importantes concernant vos voyages.",
                      ),
                    ),

                    SizedBox(width: 40),

                    Expanded(
                      child: _FeatureCard(
                        icon: Icons.travel_explore,
                        title: "Plus de destinations",
                        description:
                            "Accédez à des centaines de destinations à travers le monde.",
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: Colors.white.withOpacity(.15),
          child: Icon(icon, color: Colors.white, size: 36),
        ),

        const SizedBox(height: 20),

        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
