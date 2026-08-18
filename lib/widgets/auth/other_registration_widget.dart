import 'package:flutter/material.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/platform_widget.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/auth/facebook_authentication.dart';
import 'package:shom_gn/widgets/auth/google_authentication.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';

class OtherRegistrationWidget extends StatelessWidget {
  const OtherRegistrationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return PlatformWidget.isAndroid(context) || PlatformWidget.isWeb(context)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SubtitleTextWidget(
                        label: AppLocalizations.of(
                          context,
                        )!.label_login_connect_using.toUpperCase(),
                        fontSize: Responsive.isMobile(context)
                            ? WidgetConstants.subtitle_line * 0.8
                            : WidgetConstants.subtitle_line * 1.2,
                            color: AppColors.primary
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),

              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GoogleAuthentication(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FacebookAuthentication(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
