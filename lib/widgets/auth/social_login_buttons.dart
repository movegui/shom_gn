import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';

class SocialLoginButtons extends ConsumerStatefulWidget {
  final VoidCallback? onLoginSuccess;
  final bool isLoading;

  const SocialLoginButtons({
    super.key,
    this.onLoginSuccess,
    this.isLoading = false,
  });

  @override
  ConsumerState<SocialLoginButtons> createState() => _SocialLoginButtonsState();
}

class _SocialLoginButtonsState extends ConsumerState<SocialLoginButtons> {
  late UserService userService;
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  @override
  void initState() {
    super.initState();
    userService = getIt<UserService>();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);
    try {
      // Update with your API instance
      final user = await userService.registerWithGoogle(context);
      if (user != null) {
        widget.onLoginSuccess?.call();
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  Future<void> _handleFacebookSignIn() async {
    setState(() => _isFacebookLoading = true);
    try {
      //  final userService = UserService(api: null); // Update with your API instance
      final user = await userService.registerWithFacebook(context);
      if (user != null) {
        widget.onLoginSuccess?.call();
      }
    } catch (e) {
      print('Facebook Sign-In Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isFacebookLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        widget.isLoading || _isGoogleLoading || _isFacebookLoading;

    return Column(
      children: [
        // Divider with text
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              const Expanded(child: Divider(thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.login_title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const Expanded(child: Divider(thickness: 1)),
            ],
          ),
        ),

        // Social login buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Google Sign-In Button
            Expanded(
              child: Container(
                color: AppColors.backgroundColor,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: OutlinedButton(
                  onPressed: isLoading ? null : _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:
                      _isGoogleLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Image.asset(
                            'assets/icons/google_icon.png',
                            height: 24,
                            width: 24,
                          ),
                ),
              ),
            ),

            // Facebook Sign-In Button
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: OutlinedButton(
                  onPressed: isLoading ? null : _handleFacebookSignIn,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:
                      _isFacebookLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Image.asset(
                            'assets/icons/facebook_icon.png',
                            height: 24,
                            width: 24,
                          ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
