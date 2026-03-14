import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/core/di/injection_container.dart' as di;
import 'package:myapp/core/navigation/app_router.dart';
import 'package:myapp/core/config/app_config.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';
import 'package:myapp/presentation/viewmodel/theme_viewmodel.dart';
import 'package:myapp/core/config/app_theme.dart';
import 'package:myapp/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = AppConfig.fromEnvironment();

  if (appConfig.enableFirebase) {
    try {
      await Firebase.initializeApp().timeout(const Duration(seconds: 3));
    } catch (e) {
      debugPrint('Firebase initialization skipped: $e');
    }
  }

  try {
    await di.init(appConfig);
  } catch (e) {
    debugPrint('Dependency injection initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Premium color scheme from seed
    // final colorScheme = ColorScheme.fromSeed(
    //   seedColor: Colors.indigo,
    //   brightness: Brightness.light,
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<RandomNumberViewModel>()),
        ChangeNotifierProvider(create: (_) => di.sl<ThemeViewModel>()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Flutter Premium Template',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: AppRouter.router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('es')],
          );
        },
      ),
    );
  }
}
