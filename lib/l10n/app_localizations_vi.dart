// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Khám phá người dùng GitHub';

  @override
  String get usersTitle => 'Danh sách GitHub';

  @override
  String get retry => 'Thử lại';

  @override
  String get searchHint => 'Tìm username GitHub...';

  @override
  String get emptyState => 'Chưa có dữ liệu. Hãy tìm thử.';

  @override
  String get errorState => 'Có lỗi xảy ra';

  @override
  String get details => 'Chi tiết';
}
