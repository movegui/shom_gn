import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_constants.dart';
import 'package:shom_gn/consts/route_contants.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/button_info.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/app/app_search_widget.dart';
import 'package:shom_gn/widgets/util/button_widget.dart';
import 'package:shom_gn/widgets/web/profile_menu_widget.dart';

class WebAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  WebAppBar({super.key, required this.title});
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final currentUser = ref.watch(userProviderState).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              onPressed: (item) async {
                context.push(RouteConstants.HOME_ROUTE);
              },
              buttonItem: ButtonInfo(title: AppConstants.name, enabled: true),
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/icons/shom-logo.jpg',
                  width: 24,
                  height: 24,
                ),
              ),
              textStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SizedBox(width: WidgetConstants.sepWidgetWidth),
          const Icon(Icons.location_on),
          //   CurrentPositionWidget(),
          const SizedBox(width: WidgetConstants.sepWidgetWidth),

          Expanded(
            child: AppSearchWidget(
              controller: controller,
              focusNode: focusNode,
            ),
          ),

          const SizedBox(width: WidgetConstants.sepWidgetWidth),
          if (user != null)
            ProfileMenuWidget(user: currentUser)
          else
            showConnectionBtn(context),
        ],
      ),
    );
  }

  Widget showConnectionBtn(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.LOGIN_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_login_web,
              enabled: true,
            ),
            icon: Icon(Icons.login),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.REGISTER_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_registration,
              enabled: true,
            ),
            icon: Icon(Icons.person),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
