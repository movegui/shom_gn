import 'package:flutter/material.dart';
import 'package:shom_gn/consts/constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/services/assets_manager.dart';
import 'package:shom_gn/widgets/web/tab_item.dart';


class AppConstants {
  static const String imageUrl = 'https://i.ibb.co/JM0KMG0/riz-gras.jpg';
  //  'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static const name = "Shom-GN";
  static const Adresse = "Ratoma";
  static const LOGIN_PHONE_MODE = 1;
  static const LONGIN_EMAIL_MODE = 2;
  static const MAX_ADRESSES = 5;

  static List<String> daysOfWeek = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samdei",
    "Dimanche",
  ];

  
  static List<TabItem> menuTabs(AppLocalizations localizations) => [
    TabItem(
      title: localizations.category_discovery_name,
      icon: Icons.explore,
      routeName: '/home',
      enabled: true,
    ),
    TabItem(
      title: localizations.category_pressing_name,
      icon: Icons.cleaning_services,
      routeName: '/pressing',
      enabled: true,
    ),
    TabItem(
      title: localizations.category_restaurant_name,
      icon: Icons.restaurant,
      routeName: '/restaurant',
      enabled: false,
    ),
    TabItem(
      title: localizations.category_patisserie_name,
      icon: Icons.store,
      routeName: '/pastry',
      enabled: false,
    ),
  ];

  static String getMunicipality(String value) {
    switch (value) {
      case 'di':
        return COMMUNE_DIXINN;
      case 'gb':
        return COMMUNE_GBESSIA;
      case 'ka':
        return COMMUNE_KALOUM;
      case 'kg':
        return COMMUNE_KAGBELEN;
      case 'ks':
        return COMMUNE_KASSA;
      case 'la':
        return COMMUNE_LAMBANYI;
      case 'ma':
        return COMMUNE_MATAM;
      case 'mn':
        return COMMUNE_MANEAH;
      case 'mt':
        return COMMUNE_MATOTO;
      case 'ra':
        return COMMUNE_RATOMA;
      case 'so':
        return COMMUNE_SONFONIA;
      case 'sn':
        return COMMUNE_SANOYAH;
      case 'to':
        return COMMUNE_TOMBOLIA;
      default:
        return '';
    }
  }

    static String getGender(String value, BuildContext context) {
      switch(value){
        case 'm': return AppLocalizations.of(context)!.gender_masculin;
        case 'f': return AppLocalizations.of(context)!.gender_female;
        default: return '';
      }
  }
}

abstract class StoreConstants extends ImageConstatnt {
  String getNameLabelText();
  String getNameHinterText();
  String getDescripLabelText();
  String getDescripHinterText();
  String getAdressLabeltext();
  String getAdressHinterText();
  String getEmailLabelText();
  String getEmailHinterText();
  String getPhoneLabelText();
  String getPhoneHinterText();
  String getSaveSuccessText();
  String getTypeStoreText();
  String getMenuTitleText();
  String getTitleName();
  String getCustomerAdressHinterText();
}

abstract class CoursesConstants {
  String getTitleName();
}

class ImageConstatnt {
  String getImageSelectionErrorText() {
    return 'Veuillez choisir une Image svp !!';
  }

  String getImageSelectionText() {
    return 'Une Erreur s\'est produite';
  }

  
}



/*
class LoginConstatnts {
  String getLoginTitle() {
    return "Connectez-vous";
  }

  String getRegisterTitle() {
    return "Enregistrez-vous";
  }
}
*/
