import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:github_user_explorer/features/users/presentation/pages/user_list_page.dart';
import 'package:github_user_explorer/features/users/presentation/pages/user_detail_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UserListPage(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final login = state.uri.queryParameters['login']!;
        final avatar = state.uri.queryParameters['avatar']!;

        return UserDetailPage(
          id: id,
          login: login,
          avatarUrl: avatar,
        );
      },
    ),
  ],
);
