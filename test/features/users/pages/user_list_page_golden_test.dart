import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:github_user_explorer/features/users/presentation/pages/user_list_page.dart';

void main() {
  testGoldens('UserListPage - initial UI', (tester) async {
    await tester.pumpWidgetBuilder(
      const MaterialApp(
        home: UserListPage(),
      ),
    );

    await screenMatchesGolden(tester, 'user_list_page_initial');
  });
}
