import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/di/injection_container.dart' as di;
import 'package:myapp/core/navigation/app_router.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';
import 'package:myapp/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Required for debugPrint

import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Use a custom error widget to show UI crashes in the app itself
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.red[900],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              const Text(
                'UI Error Detected',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                details.exception.toString(),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text(
                details.stack.toString(),
                style: const TextStyle(color: Colors.white38, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('--- APP STARTING ---');

  try {
    debugPrint('Initializing Firebase (Optional)...');
    // We use a timeout to prevent hanging if the platform skips the error
    await Firebase.initializeApp().timeout(const Duration(seconds: 3));
    debugPrint('Firebase Initialized');
  } catch (e) {
    debugPrint('Firebase skipped: Not configured or found. ($e)');
  }

  try {
    debugPrint('Initializing Dependency Injection...');
    await di.init();
    debugPrint('DI Initialized');
  } catch (e) {
    debugPrint('DI Initialization ERROR: $e');
  }

  debugPrint('Running app...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Premium color scheme from seed
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<RandomNumberViewModel>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Premium Template',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          textTheme: GoogleFonts.outfitTextTheme(),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            titleTextStyle: GoogleFonts.outfit(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routerConfig: AppRouter.router,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
      ),
    );
  }
}
