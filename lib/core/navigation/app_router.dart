import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/l10n/app_localizations.dart';
import 'package:myapp/presentation/view/random_number_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const RandomNumberScreen(),
      ),
      // Add more routes here as the app grows
    ],
    errorBuilder: (context, state) {
      final l10n = AppLocalizations.of(context);
      final prefix = l10n?.navigationErrorPrefix ?? 'Error';

      return Scaffold(body: Center(child: Text('$prefix: ${state.error}')));
    },
  );
}
