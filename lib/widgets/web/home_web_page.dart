import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/models/destination_model.dart';
import 'package:shom_gn/widgets/web/app_web_banner_widget.dart';
import 'package:shom_gn/widgets/web/destination_widget.dart';
import 'package:shom_gn/widgets/web/hero_web_section.dart';
import 'package:shom_gn/widgets/web/promotion_web_section.dart';
import 'package:shom_gn/widgets/web/section_tile_widget.dart';
import 'package:shom_gn/widgets/web/service_grid_widget.dart';

class HomeWebPage extends StatelessWidget {
  const HomeWebPage({super.key, required this.destinations});
  final List<DestinationModel> destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
            // HERO
            const HeroWebSection(),

            const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),

            // SERVICES
            SectionTileWidget("Nos Services"),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            const ServiceGridWidget(),

            const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),

            // DESTINATIONS
            SectionTileWidget("Destinations populaires"),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            DestinationWidget(destinations: destinations),

            const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),

            // PROMOTIONS
            const PromotionWebSection(),

            const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),

            AppWebBannerWidget(),
                 const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),

          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "SHOM-GN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Voyagez facilement partout dans le monde.",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: const [
                Text(
                  "Contact",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),

                SizedBox(height: 10),

                Text(
                  "+224 620 84 18 82",
                  style: TextStyle(color: Colors.white70),
                ),

                Text(
                  "info@shomgn.com",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
