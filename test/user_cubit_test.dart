import 'package:flutter_test/flutter_test.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late MockGetUsers mockGetUsers;
  late UserCubit cubit;

  setUp(() {
    mockGetUsers = MockGetUsers();
    cubit = UserCubit(mockGetUsers);
  });

  test('emits [Loading, Loaded] when success', () async {
    when(() => mockGetUsers(query: any(named: 'query'))).thenAnswer(
      (_) async => [
        GithubUser(
          id: 1,
          login: 'octocat',
          avatarUrl: 'https://example.com/a.png',
          htmlUrl: 'https://github.com/octocat',
        )
      ],
    );

    expectLater(
      cubit.stream,
      emitsInOrder([isA<UserLoading>(), isA<UserLoaded>()]),
    );

    await cubit.fetchUsers(query: 'octocat');
  });

  test('emits [Loading, Error] when failure', () async {
    when(() => mockGetUsers(query: any(named: 'query'))).thenThrow(Exception('network'));

    expectLater(
      cubit.stream,
      emitsInOrder([isA<UserLoading>(), isA<UserError>()]),
    );

    await cubit.fetchUsers(query: 'octocat');
  });
}
