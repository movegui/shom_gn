import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shom_gn/app_router.dart';
import 'package:shom_gn/config/env.dart';
import 'package:shom_gn/config/env_dev.dart';
import 'package:shom_gn/config/firebase_config.dart';
import 'package:shom_gn/consts/theme_data.dart';
import 'package:shom_gn/firebase_options.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/user_model.dart';
import 'package:shom_gn/providers/theme_provider.dart';
import 'package:shom_gn/services/register_services.dart';
import 'package:flutter_riverpod/legacy.dart' show ChangeNotifierProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<UserModel>('user_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final env = EnvDev();
  initServices(env);
  await FirebaseConfig.init(env);
  runApp(ProviderScope(child: MoveguiApp(env: env)));
}

class MoveguiApp extends ConsumerWidget {
  final Env env;
  const MoveguiApp({super.key, required this.env});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ChangeNotifierProvider<ThemeProvider>(
      (ref) => ThemeProvider(),
    );

    final router = ref.watch(AppRouter.routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('fr'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      title: 'Shom_GN',
      theme: Styles.themeData(
        ref.watch(themeProvider),
        isDarkTheme: false,
        context: context,
      ),
      routerConfig: router,
    );
  }
}


/*
firebase emulators:start --config firebase.test.json
 */