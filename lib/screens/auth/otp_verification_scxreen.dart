import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final UserModel currentUser;
  final ConfirmationResult? confirmationResult;

  const OtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.currentUser,
    this.confirmationResult,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpCode = "";
  bool isLoading = false;
  late UserService userService;

  @override
  void initState() {
    userService = getIt<UserService>();
    super.initState();
  }

  Future<void> verifyOtp(ButtonInfo item) async {
    if (otpCode.length != 6) return;

    setState(() => isLoading = true);

    try {
      if (kIsWeb || widget.confirmationResult != null) {
        await widget.confirmationResult?.confirm(otpCode);
      } else {
        await userService.verifyOtp(widget.verificationId, otpCode);
      }
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.success_registration_new_user,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      /*
      context.read<LoginModProvider>().setLoginMod(
        AppConstants.LOGIN_PHONE_MODE,
      );
      */
      widget.currentUser.isVerified = true;
      UserModel? savedUser = await userService.getByUsername(
        widget.currentUser.username ?? '',
      );
      if (savedUser != null) {
        if (savedUser.isVerified == false) {
          savedUser.isVerified = true;
          await userService.update(savedUser);
        }
        context.push(item.routeName!, extra: savedUser);
      } else {
        context.push(item.routeName!, extra: widget.currentUser);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.error_register_with_phone_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: const TextStyle(
        fontSize: WidgetConstants.subTitleFontSize,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight * 2),
          child: Container(
            padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight * 3),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 380),
            decoration: BoxDecoration(
          //    color: AppColors.textColor,
              borderRadius: BorderRadius.circular(
                WidgetConstants.sepWidgetHeight * 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.verified,),
                ),
                const SizedBox(height: WidgetConstants.sepWidgetHeight * 2),
                Text(
                  AppLocalizations.of(context)!.label_enter_your_code,
                  style: TextStyle(
                    fontSize: WidgetConstants.sepWidgetHeight * 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: WidgetConstants.sepWidgetHeight * 3),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  onCompleted: (value) => otpCode = value,
                ),
                const SizedBox(height: WidgetConstants.sepWidgetHeight * 3),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ValidationButton(
                    fn: isLoading ? (item) async {} : verifyOtp,
                    buttonItem: ButtonInfo(
                      title: AppLocalizations.of(context)!.btn_send_label,
                      enabled: true,
                      routeName: RouteConstants.PROFILE_ROUTE,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    userService.registerWithPhone(context, widget.currentUser);
                  },
                  child: Text(AppLocalizations.of(context)!.resend_code),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
