import 'dart:async';
import 'package:flutter/material.dart';
import 'package:github_user_explorer/app.dart';
import 'package:github_user_explorer/core/di/injection.dart';
import 'package:github_user_explorer/core/utils/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint("🔥 Flutter Error: ${details.exception}");
  };

  //Dùng runZonedGuarded để bắt mọi lỗi “rơi tự do”
  runZonedGuarded(() async {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'DEV');
    const baseUrl = 'https://api.github.com';


    final theme = switch (flavor) {
      'PROD' => ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
      _ => ThemeData.light(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
    };

    final config = AppConfig(
      baseUrl: baseUrl,
      flavor: flavor,
      theme: theme,
      useMockRepo: false,
      child: const MyApp(),
    );

    await setupDependencies(config);

    runApp(config);
  }, (error, stack) {
    debugPrint("🔥 Uncaught Zone Error: $error");
  });
}
