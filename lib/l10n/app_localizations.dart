import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @no_phone_number.
  ///
  /// In en, this message translates to:
  /// **'No Phonenumber'**
  String get no_phone_number;

  /// No description provided for @no_email.
  ///
  /// In en, this message translates to:
  /// **'No Email'**
  String get no_email;

  /// No description provided for @status_actf.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get status_actf;

  /// No description provided for @status_non_actf.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get status_non_actf;

  /// No description provided for @commune_title.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get commune_title;

  /// No description provided for @gender_masculin.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_masculin;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @max_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'48h maximum'**
  String get max_delivery_time;

  /// No description provided for @fast_and_efficient.
  ///
  /// In en, this message translates to:
  /// **'Fast and Efficient'**
  String get fast_and_efficient;

  /// No description provided for @collect_delivery.
  ///
  /// In en, this message translates to:
  /// **'Collection & Delivery'**
  String get collect_delivery;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @store_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get store_open;

  /// No description provided for @store_closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get store_closed;

  /// Text for search Button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// the adress label
  ///
  /// In en, this message translates to:
  /// **'Adress'**
  String get company_adresse_label;

  /// the phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get company_label_phone;

  /// the Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get company_label_email;

  /// No description provided for @success_send_message_title.
  ///
  /// In en, this message translates to:
  /// **'Message send'**
  String get success_send_message_title;

  /// No description provided for @success_send_message_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your message'**
  String get success_send_message_message;

  /// No description provided for @success_registration_new_user.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully created'**
  String get success_registration_new_user;

  /// No description provided for @success_login_message.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get success_login_message;

  /// No description provided for @success_login_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Link sent successfully'**
  String get success_login_reset_password;

  /// No description provided for @success_username_updated.
  ///
  /// In en, this message translates to:
  /// **'Username Updated successfully'**
  String get success_username_updated;

  /// No description provided for @login_forget_password_txt.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you a link to reset your password '**
  String get login_forget_password_txt;

  /// No description provided for @error_send_mail_title.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get error_send_mail_title;

  /// No description provided for @error_send_mail_message.
  ///
  /// In en, this message translates to:
  /// **'You must sign before using this functionnality'**
  String get error_send_mail_message;

  /// No description provided for @error_input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Please write your message.'**
  String get error_input_hint_message;

  /// No description provided for @error_firebase_initialisation.
  ///
  /// In en, this message translates to:
  /// **'FirebaseAuth initialization failed:'**
  String get error_firebase_initialisation;

  /// No description provided for @error_login_message.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get error_login_message;

  /// No description provided for @error_login_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found in the database, please check your email and password'**
  String get error_login_user_not_found;

  /// No description provided for @error_register_with_phone_title.
  ///
  /// In en, this message translates to:
  /// **'Registration Error'**
  String get error_register_with_phone_title;

  /// No description provided for @error_register_with_phone_message.
  ///
  /// In en, this message translates to:
  /// **'We were unable to register your phone number. Please try again !'**
  String get error_register_with_phone_message;

  /// No description provided for @error_order_minimum_title.
  ///
  /// In en, this message translates to:
  /// **'Minimum Order'**
  String get error_order_minimum_title;

  /// No description provided for @error_order_minimum_message.
  ///
  /// In en, this message translates to:
  /// **'Please add items to proceed with your order.'**
  String get error_order_minimum_message;

  /// No description provided for @error_user_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get error_user_not_found_title;

  /// No description provided for @error_user_not_found_message.
  ///
  /// In en, this message translates to:
  /// **'The specified user does not exist.'**
  String get error_user_not_found_message;

  /// No description provided for @label_login_facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get label_login_facebook;

  /// No description provided for @label_login_google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get label_login_google;

  /// No description provided for @btn_close_label.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get btn_close_label;

  /// No description provided for @btn_send_label.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send_label;

  /// No description provided for @btn_register_label.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get btn_register_label;

  /// No description provided for @btn_order_label.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get btn_order_label;

  /// No description provided for @btn_call_label.
  ///
  /// In en, this message translates to:
  /// **'Appeler'**
  String get btn_call_label;

  /// No description provided for @btn_add_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get btn_add_cart;

  /// No description provided for @btn_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btn_cancel;

  /// No description provided for @btn_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btn_delete;

  /// No description provided for @btn_payment_title.
  ///
  /// In en, this message translates to:
  /// **'To Pay'**
  String get btn_payment_title;

  /// No description provided for @btn_checkout_title.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get btn_checkout_title;

  /// No description provided for @verify_otp.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get verify_otp;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// No description provided for @form_contact_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Form:'**
  String get form_contact_title;

  /// No description provided for @input_hint_first_name.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get input_hint_first_name;

  /// No description provided for @input_hint_last_name.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get input_hint_last_name;

  /// No description provided for @input_hint_adress_email.
  ///
  /// In en, this message translates to:
  /// **'Email Adress'**
  String get input_hint_adress_email;

  /// No description provided for @input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Your Message...'**
  String get input_hint_message;

  /// No description provided for @input_hint_adress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get input_hint_adress;

  /// No description provided for @input_hint_middle_name.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get input_hint_middle_name;

  /// No description provided for @input_hint_quartier.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get input_hint_quartier;

  /// No description provided for @input_hint_longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get input_hint_longitude;

  /// No description provided for @input_hint_latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get input_hint_latitude;

  /// No description provided for @movegui_info_title.
  ///
  /// In en, this message translates to:
  /// **'MoveGui – Motorcycle Delivery & Transport in Guinea'**
  String get movegui_info_title;

  /// No description provided for @movegui_info_text_1.
  ///
  /// In en, this message translates to:
  /// **'MoveGui is an innovative company specialising in food delivery and motorcycle transport in Guinea.Our mission is to make delivery more accessible, more transparent and more affordable for everyone.'**
  String get movegui_info_text_1;

  /// No description provided for @movegui_info_text_2.
  ///
  /// In en, this message translates to:
  /// **'We offer a fixed price for every journey, regardless of the distance, ensuring complete transparency for our customers.No more price surprises – just a fast, reliable and straightforward service..'**
  String get movegui_info_text_2;

  /// No description provided for @movegui_info_text_3.
  ///
  /// In en, this message translates to:
  /// **'Thanks to our partnerships with local restaurants, we offer low-cost deliveries whilst supporting the local economy.MoveGui is the perfect blend of technology, accessibility and efficiency.'**
  String get movegui_info_text_3;

  /// No description provided for @deactivate_button_title.
  ///
  /// In en, this message translates to:
  /// **'Service Unavailable '**
  String get deactivate_button_title;

  /// No description provided for @deactivate_button_message.
  ///
  /// In en, this message translates to:
  /// **'Service currently unavailable'**
  String get deactivate_button_message;

  /// No description provided for @deactivate_button_attach_message.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get deactivate_button_attach_message;

  /// No description provided for @activate_button_attach_message.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get activate_button_attach_message;

  /// No description provided for @category_courses_name.
  ///
  /// In en, this message translates to:
  /// **'Races'**
  String get category_courses_name;

  /// No description provided for @category_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get category_restaurant_name;

  /// No description provided for @category_patisserie_name.
  ///
  /// In en, this message translates to:
  /// **'Pastry shop'**
  String get category_patisserie_name;

  /// No description provided for @category_supermarche_name.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get category_supermarche_name;

  /// No description provided for @category_supplier_name.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get category_supplier_name;

  /// No description provided for @category_pressing_name.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning'**
  String get category_pressing_name;

  /// No description provided for @category_discovery_name.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get category_discovery_name;

  /// No description provided for @category_boulangerie_name.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get category_boulangerie_name;

  /// No description provided for @category_pharmacy_name.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get category_pharmacy_name;

  /// No description provided for @category_beauty_name.
  ///
  /// In en, this message translates to:
  /// **'Beauty & Care'**
  String get category_beauty_name;

  /// No description provided for @categroy_store_name.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get categroy_store_name;

  /// No description provided for @category_shop_name.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get category_shop_name;

  /// No description provided for @category_wholesaler_name.
  ///
  /// In en, this message translates to:
  /// **'Wholesaler'**
  String get category_wholesaler_name;

  /// No description provided for @category_profession_name.
  ///
  /// In en, this message translates to:
  /// **'Professions'**
  String get category_profession_name;

  /// No description provided for @category_fast_food_name.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get category_fast_food_name;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// No description provided for @movegui_title.
  ///
  /// In en, this message translates to:
  /// **'Movegui'**
  String get movegui_title;

  /// No description provided for @command_title.
  ///
  /// In en, this message translates to:
  /// **'Command'**
  String get command_title;

  /// No description provided for @delivery_title.
  ///
  /// In en, this message translates to:
  /// **'Delivey'**
  String get delivery_title;

  /// No description provided for @courier_title.
  ///
  /// In en, this message translates to:
  /// **'Courier'**
  String get courier_title;

  /// No description provided for @pressing_title.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning'**
  String get pressing_title;

  /// No description provided for @pressing_order_title.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning Order'**
  String get pressing_order_title;

  /// No description provided for @pressing_service_title.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get pressing_service_title;

  /// No description provided for @pressing_service_washing.
  ///
  /// In en, this message translates to:
  /// **'Washing'**
  String get pressing_service_washing;

  /// No description provided for @pressing_service_dry_cleaning.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning'**
  String get pressing_service_dry_cleaning;

  /// No description provided for @pressing_service_ironing.
  ///
  /// In en, this message translates to:
  /// **'Ironing'**
  String get pressing_service_ironing;

  /// No description provided for @pressing_service_laundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry '**
  String get pressing_service_laundry;

  /// No description provided for @pressing_service_folding.
  ///
  /// In en, this message translates to:
  /// **'Folding'**
  String get pressing_service_folding;

  /// No description provided for @pressing_service_stain_removal.
  ///
  /// In en, this message translates to:
  /// **'Stain Removal'**
  String get pressing_service_stain_removal;

  /// No description provided for @pressing_service_service_express.
  ///
  /// In en, this message translates to:
  /// **'Service express'**
  String get pressing_service_service_express;

  /// No description provided for @pressing_service_home_laundry.
  ///
  /// In en, this message translates to:
  /// **'Home Laundry'**
  String get pressing_service_home_laundry;

  /// No description provided for @pressing_service_work_clothing.
  ///
  /// In en, this message translates to:
  /// **'Care of Work Clothing'**
  String get pressing_service_work_clothing;

  /// No description provided for @pressing_service_delicate_fabrics.
  ///
  /// In en, this message translates to:
  /// **'Care of Delicate Fabrics'**
  String get pressing_service_delicate_fabrics;

  /// No description provided for @pressing_service_washing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Washing clothes with water'**
  String get pressing_service_washing_descrip;

  /// No description provided for @pressing_service_dry_cleaning_descrip.
  ///
  /// In en, this message translates to:
  /// **'Special cleaning for delicate fabrics'**
  String get pressing_service_dry_cleaning_descrip;

  /// No description provided for @pressing_service_ironing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Remove wrinkles with an iron or a press'**
  String get pressing_service_ironing_descrip;

  /// No description provided for @pressing_service_laundry_descrip.
  ///
  /// In en, this message translates to:
  /// **'Full-service laundry and dry cleaning'**
  String get pressing_service_laundry_descrip;

  /// No description provided for @pressing_service_folding_descrip.
  ///
  /// In en, this message translates to:
  /// **'Clothes folded after washing'**
  String get pressing_service_folding_descrip;

  /// No description provided for @pressing_service_stain_removal_descrip.
  ///
  /// In en, this message translates to:
  /// **'Stain removal'**
  String get pressing_service_stain_removal_descrip;

  /// No description provided for @pressing_service_service_express_descrip.
  ///
  /// In en, this message translates to:
  /// **'Same-day express cleaning'**
  String get pressing_service_service_express_descrip;

  /// No description provided for @pressing_service_home_laundry_descrip.
  ///
  /// In en, this message translates to:
  /// **'Sheets, blankets, curtains, etc...'**
  String get pressing_service_home_laundry_descrip;

  /// No description provided for @pressing_service_work_clothing_descrip.
  ///
  /// In en, this message translates to:
  /// **'Uniforms, Suits, Work Clothes'**
  String get pressing_service_work_clothing_descrip;

  /// No description provided for @pressing_service_delicate_fabrics_descrip.
  ///
  /// In en, this message translates to:
  /// **'Silk, Wool, Leather, Evening gowns, etc...'**
  String get pressing_service_delicate_fabrics_descrip;

  /// No description provided for @pressing_service_article_title.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get pressing_service_article_title;

  /// No description provided for @pressing_service_article_qty.
  ///
  /// In en, this message translates to:
  /// **'Qté'**
  String get pressing_service_article_qty;

  /// No description provided for @pressing_service_article_price.
  ///
  /// In en, this message translates to:
  /// **'Prix'**
  String get pressing_service_article_price;

  /// No description provided for @pressing_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Dry Cleaning Detail'**
  String get pressing_detail_title;

  /// No description provided for @pressing_detail_text_1.
  ///
  /// In en, this message translates to:
  /// **'Please note: Price to be confirmed by text message before washing!!!'**
  String get pressing_detail_text_1;

  /// No description provided for @pressing_detail_text_2.
  ///
  /// In en, this message translates to:
  /// **'The final price may vary depending on the condition of the clothes. Washing will begin once confirmation has been received via text message'**
  String get pressing_detail_text_2;

  /// No description provided for @my_orders_title.
  ///
  /// In en, this message translates to:
  /// **'Mes Commandes'**
  String get my_orders_title;

  /// No description provided for @my_deliveries_title.
  ///
  /// In en, this message translates to:
  /// **'Mes Livraisons'**
  String get my_deliveries_title;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @navigation_menu_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Navigation Menu'**
  String get navigation_menu_tooltip;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_title;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get register_title;

  /// No description provided for @forget_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgetten Password'**
  String get forget_password_title;

  /// No description provided for @label_login_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgotten your password?'**
  String get label_login_forget_password;

  /// No description provided for @label_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get label_login;

  /// No description provided for @label_login_connect_using.
  ///
  /// In en, this message translates to:
  /// **'Or connect using'**
  String get label_login_connect_using;

  /// No description provided for @label_login_invite.
  ///
  /// In en, this message translates to:
  /// **'Invité ?'**
  String get label_login_invite;

  /// No description provided for @label_login_new_user.
  ///
  /// In en, this message translates to:
  /// **'Nouveau ?'**
  String get label_login_new_user;

  /// No description provided for @label_registration.
  ///
  /// In en, this message translates to:
  /// **'Sign-up'**
  String get label_registration;

  /// No description provided for @label_enter_your_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your Code:'**
  String get label_enter_your_code;

  /// No description provided for @exception_login_message.
  ///
  /// In en, this message translates to:
  /// **'The Supplied User credential is incorrect, Please check your email address and password'**
  String get exception_login_message;

  /// No description provided for @tooltip_sign_in_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get tooltip_sign_in_with_google;

  /// No description provided for @tooltip_sign_in_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get tooltip_sign_in_with_facebook;

  /// No description provided for @tooltip_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Clic here to Connect'**
  String get tooltip_sign_in;

  /// No description provided for @tooltip_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Click here to reset password :)'**
  String get tooltip_forget_password;

  /// No description provided for @tooltip_registration.
  ///
  /// In en, this message translates to:
  /// **'Cliquez ici pour vous enregistrer :)'**
  String get tooltip_registration;

  /// No description provided for @tooltip_btn_send.
  ///
  /// In en, this message translates to:
  /// **'Click here to submit your code'**
  String get tooltip_btn_send;

  /// No description provided for @tooltip_btn_order.
  ///
  /// In en, this message translates to:
  /// **'Click here to Order'**
  String get tooltip_btn_order;

  /// No description provided for @tooltip_btn_call.
  ///
  /// In en, this message translates to:
  /// **'Click here to call'**
  String get tooltip_btn_call;

  /// No description provided for @tooltip_btn_add_cart.
  ///
  /// In en, this message translates to:
  /// **'Click here to add to cart'**
  String get tooltip_btn_add_cart;

  /// No description provided for @tooltip_btn_add_adress.
  ///
  /// In en, this message translates to:
  /// **'Click here to add new Adress'**
  String get tooltip_btn_add_adress;

  /// No description provided for @btn_add_adress.
  ///
  /// In en, this message translates to:
  /// **'Add Adress'**
  String get btn_add_adress;

  /// No description provided for @btn_update_adress.
  ///
  /// In en, this message translates to:
  /// **'Update Adress'**
  String get btn_update_adress;

  /// No description provided for @btn_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get btn_update;

  /// No description provided for @profile_menu_invite_people.
  ///
  /// In en, this message translates to:
  /// **'Invite a Friend'**
  String get profile_menu_invite_people;

  /// No description provided for @profile_menu_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get profile_menu_orders;

  /// No description provided for @profile_menu_message.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get profile_menu_message;

  /// No description provided for @profile_menu_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get profile_menu_important;

  /// No description provided for @profile_menu_devices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get profile_menu_devices;

  /// No description provided for @profile_menu_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profile_menu_account;

  /// No description provided for @profile_menu_confidentiality.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get profile_menu_confidentiality;

  /// No description provided for @profile_menu_discussions.
  ///
  /// In en, this message translates to:
  /// **'Discussions'**
  String get profile_menu_discussions;

  /// No description provided for @profile_menu_notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profile_menu_notification;

  /// No description provided for @profile_menu_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profile_menu_delete_account;

  /// No description provided for @profile_menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_menu_logout;

  /// No description provided for @profile_menu_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get profile_menu_login;

  /// No description provided for @payement_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get payement_cash;

  /// No description provided for @payement_from.
  ///
  /// In en, this message translates to:
  /// **'From 5 000 GNF / Clothing'**
  String get payement_from;

  /// No description provided for @order_now.
  ///
  /// In en, this message translates to:
  /// **'Order now'**
  String get order_now;

  /// No description provided for @order_after.
  ///
  /// In en, this message translates to:
  /// **'Order for tomorrow'**
  String get order_after;

  /// No description provided for @user_info.
  ///
  /// In en, this message translates to:
  /// **'User Infos'**
  String get user_info;

  /// No description provided for @address_office_title.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get address_office_title;

  /// No description provided for @address_neighbor_title.
  ///
  /// In en, this message translates to:
  /// **'Neighbord'**
  String get address_neighbor_title;

  /// No description provided for @address_home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get address_home_title;

  /// No description provided for @address_other_title.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get address_other_title;

  /// No description provided for @add_new_adress_title.
  ///
  /// In en, this message translates to:
  /// **'Add new Address'**
  String get add_new_adress_title;

  /// No description provided for @detail_delivery_title.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details'**
  String get detail_delivery_title;

  /// No description provided for @detail_delivery_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get detail_delivery_pickup;

  /// No description provided for @detail_delivery_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery Location '**
  String get detail_delivery_delivery;

  /// No description provided for @detail_delivery_pickup_date.
  ///
  /// In en, this message translates to:
  /// **'Select Pickup Date'**
  String get detail_delivery_pickup_date;

  /// No description provided for @detail_delivery_delivery_date.
  ///
  /// In en, this message translates to:
  /// **'Select Delivery Date'**
  String get detail_delivery_delivery_date;

  /// No description provided for @standard_address.
  ///
  /// In en, this message translates to:
  /// **'Standard Address'**
  String get standard_address;

  /// No description provided for @account_title.
  ///
  /// In en, this message translates to:
  /// **'Your Account'**
  String get account_title;

  /// No description provided for @account_info.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get account_info;

  /// No description provided for @account_edit_name.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Name'**
  String get account_edit_name;

  /// No description provided for @account_edit_email.
  ///
  /// In en, this message translates to:
  /// **'Change Email Address'**
  String get account_edit_email;

  /// No description provided for @account_edit_phone.
  ///
  /// In en, this message translates to:
  /// **'Change Phone Number'**
  String get account_edit_phone;

  /// No description provided for @account_adresse.
  ///
  /// In en, this message translates to:
  /// **'Manage Addresses'**
  String get account_adresse;

  /// No description provided for @account_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get account_password;

  /// No description provided for @account_edit_name_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Name'**
  String get account_edit_name_title;

  /// No description provided for @account_edit_name_new_name.
  ///
  /// In en, this message translates to:
  /// **'New Name'**
  String get account_edit_name_new_name;

  /// No description provided for @account_edit_email_new_email.
  ///
  /// In en, this message translates to:
  /// **'New Email Address'**
  String get account_edit_email_new_email;

  /// No description provided for @account_edit_phone_new_phone.
  ///
  /// In en, this message translates to:
  /// **'New Phone Number'**
  String get account_edit_phone_new_phone;

  /// No description provided for @compte_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get compte_delete_title;

  /// No description provided for @compte_delete_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action is irreversible.'**
  String get compte_delete_message;

  /// No description provided for @max_adress_title.
  ///
  /// In en, this message translates to:
  /// **'Maximum Adresses'**
  String get max_adress_title;

  /// No description provided for @max_adress_message.
  ///
  /// In en, this message translates to:
  /// **'The maximum number of addresses is 5 per user. Please delete any others.'**
  String get max_adress_message;

  /// No description provided for @dialog_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get dialog_confirm_title;

  /// No description provided for @dialog_confirm_message.
  ///
  /// In en, this message translates to:
  /// **'Would you like to save the changes ?'**
  String get dialog_confirm_message;

  /// No description provided for @dialog_btn_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get dialog_btn_yes;

  /// No description provided for @dialog_btn_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get dialog_btn_no;

  /// No description provided for @payment_title.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment_title;

  /// No description provided for @address_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pick-up'**
  String get address_pickup;

  /// No description provided for @address_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get address_delivery;

  /// No description provided for @address_default_title.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get address_default_title;

  /// No description provided for @pickup_pressing.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning drop-off'**
  String get pickup_pressing;

  /// No description provided for @delivery_pressing.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning pickup'**
  String get delivery_pressing;

  /// No description provided for @current_position.
  ///
  /// In en, this message translates to:
  /// **'Current Position'**
  String get current_position;

  /// No description provided for @my_position.
  ///
  /// In en, this message translates to:
  /// **'My Position'**
  String get my_position;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
