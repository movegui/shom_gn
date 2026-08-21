import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/destination_model.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:shom_gn/services/user_service.dart';
import 'package:shom_gn/widgets/mobile/home_mobile_page.dart';
import 'package:shom_gn/widgets/web/home_web_page.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    this.selectedTabIndex,
    this.onTabChange,
    this.currentScreen,
  });
  final bool isHorizontal = false;
  final int? selectedTabIndex;
  final int? currentScreen;
  final Function(int index)? onTabChange;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late UserService userService;

  List<DestinationModel> destinations = [
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "paris",
      price: 399,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Dubai",
      price: 299,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Conakry",
      price: 199,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
    DestinationModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      city: "Istanbul",
      price: 99,
      imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    ),
  ];

  @override
  void initState() {
    super.initState();
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final l10n = AppLocalizations.of(context)!;
    await userService.checkLoginState(l10n.error_login_user_not_found);

    final currentUser = await userService.getByEmail(
      FirebaseAuth.instance.currentUser?.email ?? '',
    );

    if (currentUser == null) {
      if (!mounted) return;

      await userService.signOut();

      Fluttertoast.showToast(
        msg: l10n.error_login_message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );

      return;
    } else {
      ref.read(userProviderState).setUser(currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) ? _buildDesktop() : _buildMobile();
  }

  Widget _buildMobile() {
    return HomeMobilePage(destinations: destinations);
  }

  Widget _buildDesktop() {
    return HomeWebPage(destinations: destinations);
  }
}
