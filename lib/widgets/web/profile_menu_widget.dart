import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';
import 'package:shom_gn/widgets/util/profile_menu_title.dart';

class ProfileMenuWidget extends StatelessWidget {
  /*
  final String? name;
  final String? email;
  final String? photoUrl;
  final VoidCallback? onLogout;
  */
  final UserModel? user;

  const ProfileMenuWidget({
    super.key,
    /*
    this.name,
    this.email,
    this.photoUrl,
    this.onLogout,
    */
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<String>(
      tooltip: '',
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        switch (value) {
          case 'profile':
            context.go('/profile');
            break;

          case 'bookings':
            context.go('/my-bookings');
            break;

          case 'favorite':
            context.go('/favorites');
            break;

          case 'settings':
            context.go('/settings');
            break;

          case 'logout':
            //   onLogout?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user?.name ?? '', style: theme.textTheme.displayMedium),
              if (user?.personModel?.email != null)
                Text(
                  user?.personModel?.email ?? 'Pas d\'Email',
                  style: theme.textTheme.displaySmall,
                ),
            ],
          ),
        ),
        const PopupMenuDivider(),

        PopupMenuItem(
          value: 'profile',
          child: ProfileMenuTitle(
            icon: Icons.person_outline,
            title: AppLocalizations.of(context)!.my_profile_title,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        PopupMenuItem(
          value: 'bookings',
          child: ProfileMenuTitle(
            icon: Icons.flight,
            title: AppLocalizations.of(context)!.my_reservation_title,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        PopupMenuItem(
          value: 'favorite',
          child: ProfileMenuTitle(
            icon: Icons.history,
            title: AppLocalizations.of(context)!.my_trips,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        PopupMenuItem(
          value: 'settings',
          child: ProfileMenuTitle(
            icon: Icons.settings_outlined,
            title: AppLocalizations.of(context)!.settings_title,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        const PopupMenuDivider(),

        PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              AppLocalizations.of(context)!.profile_menu_logout,
              style: TextStyle(color: Colors.red),
            ),
            contentPadding: EdgeInsets.zero,
            onTap: () async => {await FirebaseAuth.instance.signOut()},
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: user?.personModel?.profileImageUrl != null
                  ? NetworkImage(user!.personModel!.profileImageUrl!)
                  : null,
              child: user?.personModel?.profileImageUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 10),

            Text(
              user?.name ?? 'Compte',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),

            const SizedBox(width: 4),

            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Future<dynamic> notImplemented(BuildContext context) {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
