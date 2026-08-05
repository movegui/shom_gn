import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/platform_widget.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/app/my_appbar.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/login_email_page.dart';
import 'package:shom_gn/widgets/auth/login_phone_page.dart';
import 'package:shom_gn/widgets/subtitle_text.dart';
import 'package:shom_gn/widgets/util/toogle_buttons.dart';
import 'package:shom_gn/widgets/web/menu_bar_web.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;

  bool showFirst = true;

  @override
  void initState() {
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) async {
         ref.read(appbarTitleProviderState).setTitle(AppLocalizations.of(context)!.login_title,);
    });
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        appBar:
            Responsive.isDesktop(context)
                ? MenuBarWeb(title: AppLocalizations.of(context)!.login_title)
                : MyAppBar(
            //      title: AppLocalizations.of(context)!.login_title,
                  itemCount: ref.watch(shoppingProviderState).itemCount,
                ),
        body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget buildMobil() {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 238, 230, 196),
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
  }

  Widget buildDeskop() {
    return Center(
      child: Container(
        width: 700,
        height: 700,
        decoration: BoxDecoration(
        //  color: AppColors.textColor,
          border: Border.all( width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 100, right: 100),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90, right: 80),
                    child: SubtitleTextWidget(
                      label: AppLocalizations.of(context)!.login_title,
                      fontSize: WidgetConstants.subTitleFontSize * 3,
                    ),
                  ),
                ),
                SeparatorWidget(height: 30),
                ToggleButtonExample(onStateChanged: updateState),
                SeparatorWidget(height: 20),
                currentLoginScreen == 0
                    ? LoginPhoneNumberPage()
                    : LoginEmailPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
