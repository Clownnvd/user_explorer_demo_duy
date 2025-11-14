import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:github_user_explorer/features/users/presentation/cubit/user_cubit.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';

/// Mock Repository
class MockUserRepository extends Mock implements GithubUserRepository {}

void main() {
  late MockUserRepository mockRepo;

  setUp(() {
    mockRepo = MockUserRepository();
  });

  group("UserCubit Test", () {
    blocTest<UserCubit, UserState>(
      "Emit [loading → loaded] when repository returns success",
      build: () {
        when(() => mockRepo.getUsers(query: any(named: 'query')))
            .thenAnswer((_) async => [
                  GithubUser(
                    id: 1,
                    login: "duy",
                    avatarUrl: "avatar.png",
                    htmlUrl: "github.com",
                  )
                ]);

        return UserCubit(mockRepo);
      },
      act: (cubit) => cubit.fetchUsers(query: "duy"),
      expect: () => [
        const UserState.loading(),
        // dùng predicate để kiểm tra state loaded (vì _Loaded là private)
        predicate((state) {
          final s = state as UserState; // ép kiểu
          return s.maybeWhen(
            loaded: (users) => users.isNotEmpty,
            orElse: () => false,
          );
        })
      ],
    );

    blocTest<UserCubit, UserState>(
      "Emit [loading → error] when repository throws exception",
      build: () {
        when(() => mockRepo.getUsers(query: any(named: 'query')))
            .thenThrow(Exception("Unexpected error"));

        return UserCubit(mockRepo);
      },
      act: (cubit) => cubit.fetchUsers(query: "xxx"),
      expect: () => [
        const UserState.loading(),
        predicate((state) {
          final s = state as UserState; // ép kiểu
          return state.maybeWhen(
            error: (msg) => msg.contains("error"),
            orElse: () => false,
          );
        }),
      ],
    );
  });
}
