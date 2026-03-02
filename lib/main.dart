import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/di/injection_container.dart' as di;
import 'package:myapp/core/navigation/app_router.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
      ),
    );
  }
}
