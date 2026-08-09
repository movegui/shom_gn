import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/platform_widget.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/app/app_appbar.dart';
import 'package:shom_gn/widgets/app/app_panel_mobile.dart';
import 'package:shom_gn/widgets/app/app_panel_web.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/register_email_page.dart';
import 'package:shom_gn/widgets/auth/register_phone_page.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';
import 'package:shom_gn/widgets/util/toogle_buttons.dart';
import 'package:shom_gn/widgets/web/web_appbar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with RouteAware {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;
  bool showFirst = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.register_title);
    });
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? WebAppBar(title: AppLocalizations.of(context)!.register_title)
          : AppAppbar(
              itemCount: ref.watch(shoppingProviderState).itemCount,
              title: AppLocalizations.of(context)!.register_title,
            ),
      body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
      //   ),
    );
  }

  Widget buildMobil() {
    return AppPanelMobile(
      childrens: [
        // AppImage(heightScale: 0.10),
        SeparatorWidget(),
        PlatformWidget.isAndroid(context) ||
                PlatformWidget.isIos(context) ||
                PlatformWidget.isWeb(context)
            ? ToggleButtonExample(onStateChanged: updateState)
            : const SizedBox(),
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
        currentLoginScreen == 0 ? RegisterPhonePage() : RegisterEmailPage(),
      ],
    );
    /*
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppImage(heightScale: 0.10),
              SeparatorWidget(),
              PlatformWidget.isAndroid(context) ||
                      PlatformWidget.isIos(context) ||
                      PlatformWidget.isWeb(context)
                  ? ToggleButtonExample(onStateChanged: updateState)
                  : const SizedBox(),
              SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
              currentLoginScreen == 0
                  ? RegisterPhonePage()
                  : RegisterEmailPage(),
            ],
          ),
        ),
      ),
    );
    */
  }

  Widget buildDesktop() {
    return AppPanelWeb(
      childrens: [
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
        ToggleButtonExample(onStateChanged: updateState),
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
        currentLoginScreen == 0 ? RegisterPhonePage() : RegisterEmailPage(),
      ],
      subtitle: 'Enregistrez votre compte',
      title: AppLocalizations.of(context)!.register_title,
    );
    /*
    return Center(
      child: Container(
        width: 700,
        //     height: 600,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Logo à gauche
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/icons/shom-logo.jpg',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Titre centré
                            Column(
                              children: [
                                Center(
                                  child: SubtitleTextWidget(
                                    label: AppLocalizations.of(
                                      context,
                                    )!.login_title,
                                    fontSize:
                                        WidgetConstants.subTitleFontSize * 2,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Enregistrez votre compte',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*
              Container(
                width: double.infinity,
                //   margin: EdgeInsets.only(left: 100, right: 100),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 30),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.register_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
                  ),
                ),
              ),
              */
              ToggleButtonExample(onStateChanged: updateState),
              SeparatorWidget(height: WidgetConstants.sepWidgetHeight),
              currentLoginScreen == 0
                  ? RegisterPhonePage()
                  : RegisterEmailPage(),
            ],
          ),
        ),
      ),
    );
    */
  }
}
