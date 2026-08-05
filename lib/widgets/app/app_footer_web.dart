import 'package:flutter/material.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/services/config_service.dart';
import 'package:shom_gn/widgets/title_text.dart';


class AppFooterWeb extends StatelessWidget {
  const AppFooterWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFooterConfig(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    final footerObj = snapshot.data!;
        return BottomAppBar(
          height: 100,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label: AppLocalizations.of(context)!.company_adresse_label,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(                      
                        footerObj.address,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label:  AppLocalizations.of(context)!.company_label_email,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(                     
                      footerObj.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      TitlesTextWidget(
                        label: AppLocalizations.of(context)!.company_label_phone,
                        color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      ),
                      Text(
                       footerObj.phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  
}
