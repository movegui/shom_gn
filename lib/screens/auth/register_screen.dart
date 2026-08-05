
import 'package:flutter/material.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/platform_widget.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/register_email_page.dart';
import 'package:shom_gn/widgets/auth/register_phone_page.dart';
import 'package:shom_gn/widgets/subtitle_text.dart';
import 'package:shom_gn/widgets/util/toogle_buttons.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  int currentLoginScreen = 0;
  bool showFirst = true;


  @override
  void initState() {
    super.initState();
  }

  void updateState(int state) {
    setState(() {
      currentLoginScreen = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
      ),
    );
  }

  Widget buildMobil() {
    var Size = MediaQuery.of(context).size;
    return Padding(
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
                ? RegisterPhonePage(
                )
                : RegisterEmailPage(),
          ],
        ),
      ),
    );
  }

  Widget buildDesktop() {

    return Center(
      child: Container(
        width: 700,
        height: 600,
        decoration: BoxDecoration(
          border: Border.all( width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 100, right: 100),
                child: Padding(
                  padding: const EdgeInsets.only(left: 35 , right: 30),
                  child: SubtitleTextWidget(
                    label: AppLocalizations.of(context)!.register_title,
                    fontSize: WidgetConstants.subTitleFontSize * 3,
                  ),
                ),
              ),
              SeparatorWidget(height: 30,),

              ToggleButtonExample(onStateChanged: updateState),

             SeparatorWidget(height: 20,),

              currentLoginScreen == 0
                ? RegisterPhonePage()
                : RegisterEmailPage(),
            ],
          ),
        ),
      ),
    );













/*

    return Center(
      child: Container(
        width: 500,
        //   height: 500,
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(),
            ToggleButtonExample(onStateChanged: updateState),
            SizedBox(height: 8),
            currentLoginScreen == 0
                ? RegisterPhonePage()
                : RegisterEmailPage(),
          ],
        ),
      ),
    );
    */
  }
}
