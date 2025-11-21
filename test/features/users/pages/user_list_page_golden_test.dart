import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:github_user_explorer/features/users/presentation/pages/user_list_page.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/l10n/app_localizations.dart';

class _FakeRepo implements GithubUserRepository {
  @override
  Future<List<GithubUser>> getUsers({String? query}) async => [];
}

class _FakeCubit extends UserCubit {
  _FakeCubit() : super(_FakeRepo());

  @override
  Future<void> fetchUsers({String? query}) async {
    // giữ nguyên state.initial()
  }
}

void main() {
  setUpAll(() async => loadAppFonts());

  testGoldens('UserListPage initial', (tester) async {
    await tester.pumpWidgetBuilder(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => _FakeCubit(),
          child: const UserListPage(),
        ),
      ),
    );

    await tester.pump();
    await screenMatchesGolden(tester, 'user_list_initial');
  });
}
