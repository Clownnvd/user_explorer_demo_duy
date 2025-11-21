import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:github_user_explorer/features/users/data/github_user_remote_data_source.dart';
import 'package:github_user_explorer/features/users/data/repositories/github_user_repository_impl.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/core/network/app_http_client.dart';

class MockRemote extends Mock implements GithubUserRemoteDataSource {}
class MockClient extends Mock implements AppHttpClient {}
class MockDio extends Mock implements Dio {}

void main() {
  late MockRemote remote;
  late MockClient client;
  late MockDio dio;
  late GithubUserRepositoryImpl repo;

  setUp(() {
    remote = MockRemote();
    client = MockClient();
    dio = MockDio();

    when(() => remote.client).thenReturn(client);
    when(() => client.dio).thenReturn(dio);

    repo = GithubUserRepositoryImpl(remote);
  });

  test('success → returns GithubUser list', () async {
    final response = Response(
      data: {
        "items": [
          {
            "id": 1,
            "login": "mochi",
            "avatar_url": "a.png",
            "html_url": "h",
          }
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ""),
    );

    when(() => dio.get(any(), queryParameters: any(named: "queryParameters")))
        .thenAnswer((_) async => response);

    final result = await repo.getUsers(query: "mochi");

    expect(result, isA<List<GithubUser>>());
    expect(result.first.login, "mochi");
  });

  test('error → throws Exception', () async {
    when(() => dio.get(any(), queryParameters: any(named: "queryParameters")))
        .thenThrow(
      DioException(requestOptions: RequestOptions(path: "")),
    );

    expect(() => repo.getUsers(query: "mochi"), throwsA(isA<Exception>()));
  });
}
