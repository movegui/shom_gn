import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/destination_model.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';
import 'package:shom_gn/widgets/web/app_web_banner_widget.dart';
import 'package:shom_gn/widgets/web/destination_widget.dart';

class HomeMobilePage extends StatelessWidget {
  final List<DestinationModel> destinations;

  const HomeMobilePage({super.key, required this.destinations});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            SizedBox(height: WidgetConstants.sepWidgetHeight * 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SubtitleTextWidget(
                          label: AppLocalizations.of(
                            context,
                          )!.dashbord_sentence_1,
                        ),
                      ),
                      const SizedBox(height: WidgetConstants.sepWidgetHeight),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                            ),
                            hintText: AppLocalizations.of(context)!.search,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //    const SizedBox(height: WidgetConstants.sepWidgetHeight),

            // SERVICES
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: WidgetConstants.sepWidgetHeight,
              ),
              child: SubtitleTextWidget(
                label: AppLocalizations.of(context)!.services_title,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _serviceCard(
                      icon: Icons.flight_takeoff,
                      color: Colors.blue,
                      context: context,
                      item: ButtonInfo(
                        title: AppLocalizations.of(
                          context,
                        )!.search_flight_title,
                        enabled: true,
                        routeName: RouteConstants.SEARCH_FLIGHT_ROUTE,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _serviceCard(
                      icon: Icons.hotel,
                      color: Colors.orange,
                      context: context,
                      item: ButtonInfo(
                        title: AppLocalizations.of(context)!.hotels_title,
                        enabled: false,
                        routeName: RouteConstants.SEARCH_HOTEL_ROUTE,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _serviceCard(
                      icon: Icons.luggage,
                      color: Colors.green,
                      context: context,
                      item: ButtonInfo(
                        title: AppLocalizations.of(context)!.my_trips,
                        enabled: false,
                        routeName: RouteConstants.SEARCH_MY_TRIPS_ROUTE,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _serviceCard(
                      icon: Icons.favorite,
                      color: Colors.red,
                      context: context,
                      item: ButtonInfo(
                        title: AppLocalizations.of(context)!.favoris_title,
                        enabled: false,
                        routeName: RouteConstants.FAVORITES_ROUTE,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            // DESTINATIONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SubtitleTextWidget(
                label: AppLocalizations.of(context)!.destinations_title,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            DestinationWidget(destinations: destinations),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

            AppWebBannerWidget(),

            const SizedBox(height: WidgetConstants.sepWidgetHeight),

          ],
        ),
      ),
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required Color color,
    required BuildContext context,
    required ButtonInfo item,
  }) {
    return InkWell(
      onTap: () {
        if (item.enabled) {
          if (!context.mounted) return;
          context.push(item.routeName ?? RouteConstants.HOME_ROUTE);
        } else {
          MessageWidget.errorMessage(
            context,
            AppLocalizations.of(context)!.deactivate_button_title,
            AppLocalizations.of(context)!.deactivate_button_message,
            Icon(Icons.error, color: AppColors.error),
            FlushbarPosition.TOP,
          );
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: item.enabled
              ? Theme.of(context).colorScheme.primaryContainer
              : AppColors.disabled,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(.15),
              child: Icon(
                icon,
                color: item.enabled ? color : AppColors.lightBackground,
                size: 52,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.title ?? '',
              style: item.enabled
                  ? Theme.of(context).textTheme.displayMedium
                  : TextStyle(color: AppColors.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
