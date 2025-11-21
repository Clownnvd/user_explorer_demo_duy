import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:github_user_explorer/core/router/app_router.dart';
import 'package:github_user_explorer/features/users/presentation/pages/user_list_page.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/l10n/app_localizations.dart';

class _FakeRepo implements GithubUserRepository {
  @override
  Future<List<GithubUser>> getUsers({String? query}) async {
    return [
      GithubUser(
        id: 1,
        login: "flutter",
        avatarUrl: "",
        htmlUrl: "",
      )
    ];
  }
}

void main() {
  testWidgets('tap card → navigate → detail shows flutter', (tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => UserCubit(_FakeRepo()),
        child: MaterialApp.router(
          routerConfig: appRouter,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    // đợi UserListPage load xong list
    await tester.pumpAndSettle();

    // đảm bảo có user "flutter" trên list
    expect(find.text('flutter'), findsOneWidget);

    // 👉 ẤN vào card (tap vào chính text cũng được)
    await tester.tap(find.text('flutter'));
    await tester.pumpAndSettle();

    // 👉 Màn chi tiết vẫn phải hiển thị chữ "flutter"
    expect(find.text('flutter'), findsWidgets);
  });
}
