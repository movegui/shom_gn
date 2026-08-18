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
  }
}
