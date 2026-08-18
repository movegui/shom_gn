import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/services/my_app_functions.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';


class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => GoogleAuthenticationState();
}

class GoogleAuthenticationState extends State<GoogleAuthentication> {
  bool _isLoading = false;
  late UserService userService;

  @override
  initState() {
    super.initState();
    userService = getIt<UserService>();
  }

  Future<void> _onPressed(BuildContext context, ButtonInfo item) async {
    try {
        setState(() => _isLoading = true);
        final user = await userService.registerWithGoogle(context);
        if (user != null) {
          if(!context.mounted){
               context.go(item.routeName!);
          }
      }
    } catch (e) {
     // ignore: use_build_context_synchronously
     MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: e.toString(), fct: (){});
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ?  CircularProgressIndicator() // Text('loading...' , style: Theme.of(context).textTheme.labelMedium,)   // CircularProgressIndicator()
        : ButtonWidget(
          buttonItem: ButtonInfo(
            title: AppLocalizations.of(context)!.label_login_google,
            enabled: true,
            routeName: RouteConstants.HOME_ROUTE,
          ),
          onPressed: (buttonItem) async {
            print('jojoj');
            await _onPressed(context, buttonItem);
          },
          icon: Icon(Ionicons.logo_google , size: 24,),
          textStyle: Theme.of(context).textTheme.displayLarge,
        );
  }
}
