// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GitHub User Explorer';

  @override
  String get usersTitle => 'GitHub Users';

  @override
  String get retry => 'Retry';

  @override
  String get searchHint => 'Search GitHub username...';

  @override
  String get emptyState => 'No users yet. Try searching.';

  @override
  String get errorState => 'Something went wrong';

  @override
  String get details => 'Details';
}
