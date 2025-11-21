import 'package:flutter/material.dart';
//dùng để truyền các cấu hình quan trọng của ứng dụng xuống toàn bộ cây widget.
class AppConfig extends InheritedWidget {
  final String baseUrl;
  final String flavor;
  final bool useMockRepo;
  final ThemeData theme;

  const AppConfig({
    super.key,
    required this.baseUrl,
    required this.flavor,
    this.useMockRepo = false,
    required this.theme,
    required super.child,
  });

  static AppConfig of(BuildContext context) {
    final AppConfig? result =
        context.dependOnInheritedWidgetOfExactType<AppConfig>();
    assert(result != null, 'No AppConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppConfig oldWidget) =>
      baseUrl != oldWidget.baseUrl ||
      flavor != oldWidget.flavor ||
      theme != oldWidget.theme;
}
