import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/app/app_appbar.dart';
import 'package:shom_gn/widgets/app/app_panel_mobile.dart';
import 'package:shom_gn/widgets/app/app_panel_web.dart';
import 'package:shom_gn/widgets/auth/validation_button.dart';
import 'package:shom_gn/widgets/web/web_appbar.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String? verificationId;
  final UserModel currentUser;
  final ConfirmationResult? confirmationResult;

  const OtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.currentUser,
    this.confirmationResult,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  String otpCode = "";
  bool isLoading = false;
  late UserService userService;
  final controller = TextEditingController();
  UserModel? savedUser;

  @override
  void initState() {
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.opt_screen_title);
    });
    super.initState();
  }

  Future<void> verifyOtp(BuildContext context, ButtonInfo item) async {
    if (otpCode.length != 6) return;

    setState(() => isLoading = true);

    try {
      if (kIsWeb) {
        await widget.confirmationResult!.confirm(otpCode);
      } else {
        final credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId!,
          smsCode: otpCode,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      Fluttertoast.showToast(
        // ignore: use_build_context_synchronously
        msg: AppLocalizations.of(context)!.success_registration_new_user,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      widget.currentUser.isVerified = true;
      savedUser = await userService.getByUsername(
        widget.currentUser.username ?? '',
      );
      if (savedUser != null) {
        if (savedUser?.isVerified == false) {
          savedUser?.isVerified = true;
          await userService.update(savedUser!);
        }
      } else {
        savedUser = await userService.addModel(widget.currentUser);
      }
      if (!context.mounted) return;
      context.push(item.routeName!, extra: savedUser);
    } catch (e) {
      throw Exception(Text(e.toString()));
    }

    setState(() => isLoading = false);
  }

  Widget myWidget(PinTheme defaultPinTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight),
        child: Container(
          padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight),
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 380),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(radius: 28, child: Icon(Icons.verified)),
              const SizedBox(height: WidgetConstants.sepWidgetHeight),
              Text(
                AppLocalizations.of(context)!.label_enter_your_code,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.primary),
              ),

              Pinput(
                controller: controller,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                onCompleted: (value) => otpCode = value,
                readOnly: false,
              ),
              const SizedBox(height: WidgetConstants.sepWidgetHeight),
              ValidationButton(
                fn: (item) async {
                  if (!isLoading) {
                    await verifyOtp(context, item);
                  }
                },
                buttonItem: ButtonInfo(
                  title: AppLocalizations.of(context)!.btn_send_label,
                  enabled: true,
                  routeName: RouteConstants.PROFILE_ROUTE,
                ),
                icon: Icon(Icons.upload),
              ),
              const SizedBox(height: WidgetConstants.sepWidgetHeight),
              TextButton(
                onPressed: () {
                  userService.registerWithPhone(context, widget.currentUser);
                },
                child: Text(
                  AppLocalizations.of(context)!.resend_code,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      textStyle: TextStyle(
        fontSize: WidgetConstants.subTitleFontSize,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
    );

    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? WebAppBar(title: AppLocalizations.of(context)!.opt_screen_title)
          : AppAppbar(
              itemCount: ref.watch(shoppingProviderState).itemCount,
              title: AppLocalizations.of(context)!.opt_screen_title,
            ),
      body: Responsive.isDesktop(context)
          ? AppPanelWeb(
              childrens: [myWidget(defaultPinTheme)],
              subtitle: 'Donnez votre code svp',
              title: AppLocalizations.of(context)!.opt_screen_title,
            )
          : AppPanelMobile(childrens: [myWidget(defaultPinTheme)]),
      resizeToAvoidBottomInset: true,
    );
  }
}
