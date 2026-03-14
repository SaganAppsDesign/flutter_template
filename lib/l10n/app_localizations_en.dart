// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Premium Template';

  @override
  String get homeTitle => 'Home Screen';

  @override
  String get generateNumber => 'Generate Number';

  @override
  String get currentValue => 'Current Value';

  @override
  String get toggleThemeTooltip => 'Toggle theme';

  @override
  String get poweredByTemplate => 'Powered by Clean Architecture';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get navigationErrorPrefix => 'Error';
}
