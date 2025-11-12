import 'package:flutter/material.dart';
import 'package:github_user_explorer/app.dart';
import 'package:github_user_explorer/core/di/injection.dart';
import 'package:github_user_explorer/core/utils/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'DEV');
  final baseUrl = 'https://api.github.com';

  final theme = switch (flavor) {
    'PROD' => ThemeData.dark(useMaterial3: true)
        .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
    _ => ThemeData.light(useMaterial3: true)
        .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
  };

  //mở rộng thêm textTheme và buttonTheme để chuẩn hóa style
  theme.copyWith(
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);


  final config = AppConfig(
    baseUrl: baseUrl,
    flavor: flavor,
    theme: theme,
    // Bật mock để không cần internet
    useMockRepo: false,
    child: const MyApp(),
  );

  await setupDependencies(config);

  runApp(config);
}
