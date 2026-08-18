import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/destination_model.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';
import 'package:shom_gn/widgets/util/destination_card.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  /*
  Future<void> _logout(BuildContext context) async {
    await authService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(authService: authService),
      ),
    );
  }
  */
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {

  late UserService userService;

  List<DestinationModel> destinations = [
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "paris",
      price: 399,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Dubai",
      price: 299,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Conakry",
      price: 199,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Istanbul",
      price: 99,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
  ];

@override
void initState() {
  super.initState();
  userService = getIt<UserService>();
 WidgetsBinding.instance.addPostFrameCallback((_) {
_initialize();
});
}

Future<void> _initialize() async {
  final l10n = AppLocalizations.of(context)!;
  await userService.checkLoginState(
    l10n.error_login_user_not_found,
  );

  final currentUser = await userService.getByEmail(
    FirebaseAuth.instance.currentUser?.email ?? '',
  );

  if (currentUser == null) {
    if (!mounted) return;

    await userService.signOut();

    Fluttertoast.showToast(
      msg: l10n.error_login_message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
    );

    return;
  } else {
    print('jo ich bin drin!!!!!!!!!!!!!');
     ref.read(userProviderState).setUser(currentUser);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15,
                              ),
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

              LayoutBuilder(
                builder: (context, constraints) {
                  final itemsPerRow = Responsive.isDesktop(context)
                      ? 4
                      : 2 // (constraints.maxWidth / 250)
                            .floor()
                            .clamp(1, 6);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: itemsPerRow,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1,
                        // mainAxisExtent: 250,
                      ),

                      itemCount: destinations.length,

                      itemBuilder: (context, index) {
                        return DestinationCard(
                          city: destinations[index].city,
                          price: destinations[index].price,
                          imageUrl: destinations[index].imageUrl ?? '',
                          onTap: () {},
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
