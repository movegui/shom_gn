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
import 'package:shom_gn/widgets/auth/login_email_page.dart';
import 'package:shom_gn/widgets/auth/login_phone_page.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';
import 'package:shom_gn/widgets/util/toogle_buttons.dart';
import 'package:shom_gn/widgets/web/web_appbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with RouteAware {
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
          .setTitle(AppLocalizations.of(context)!.login_title);
    });
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  if (!mounted) return CircularProgressIndicator();
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? WebAppBar(title: AppLocalizations.of(context)!.login_title)
          : AppAppbar(
              itemCount: ref.watch(shoppingProviderState).itemCount,
              title: AppLocalizations.of(context)!.login_title,
            ),
      body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
      resizeToAvoidBottomInset: true,
    );
    //   );
  }

  Widget buildMobil() {
    return AppPanelMobile(
      childrens: [
        SeparatorWidget(),
        PlatformWidget.isAndroid(context) ||
                PlatformWidget.isIos(context) ||
                PlatformWidget.isWeb(context)
            ? ToggleButtonExample(onStateChanged: updateState)
            : const SizedBox(),
        SizedBox(height: 6.0),
        currentLoginScreen == 0 ? LoginPhoneNumberPage() : LoginEmailPage(),
      ],
    );

    /*
    return Center(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeparatorWidget(),
                  PlatformWidget.isAndroid(context) ||
                          PlatformWidget.isIos(context) ||
                          PlatformWidget.isWeb(context)
                      ? ToggleButtonExample(onStateChanged: updateState)
                      : const SizedBox(),
                  SizedBox(height: 6.0),
                  currentLoginScreen == 0
                      ? LoginPhoneNumberPage()
                      : LoginEmailPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    */
  }

  Widget buildDeskop() {
    return AppPanelWeb(
      childrens: [
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
        ToggleButtonExample(onStateChanged: updateState),
        SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
        currentLoginScreen == 0 ? LoginPhoneNumberPage() : LoginEmailPage(),
      ],
      subtitle: 'Connectez-vous à votre compte',
      title: AppLocalizations.of(context)!.login_title,
    );
    /*
    return Center(
      child: Container(
        width: 700,
        //   height: 700,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
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
                                    'Connectez-vous à votre compte',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
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
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
                ToggleButtonExample(onStateChanged: updateState),
                SeparatorWidget(height: WidgetConstants.sepWidgetHeight * 1.5),
                currentLoginScreen == 0
                    ? LoginPhoneNumberPage()
                    : LoginEmailPage(),
              ],
            ),
          ),
        ),
      ),
    );
    */
  }
}
