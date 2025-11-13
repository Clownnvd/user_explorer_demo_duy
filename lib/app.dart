import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_user_explorer/core/di/injection.dart';
import 'package:github_user_explorer/core/router/app_router.dart';
import 'package:github_user_explorer/core/utils/app_config.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(getIt<GetUsers>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'GitHub User Explorer',
        debugShowCheckedModeBanner: false,
        theme: config.theme,
        routerConfig: appRouter,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
