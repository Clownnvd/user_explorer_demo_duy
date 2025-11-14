import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/users/data/github_user_remote_data_source.dart';
import '../../features/users/data/repositories/github_user_repository_impl.dart';
import '../../features/users/data/repositories/github_user_repository_mock.dart';
import '../../features/users/domain/repositories/github_user_repository.dart';
import '../../features/users/domain/usecases/get_users.dart';
import '../../features/users/presentation/cubit/user_cubit.dart';
import '../network/app_http_client.dart';
import '../utils/app_config.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies(AppConfig config) async {
  // 1. Config
  getIt.registerSingleton<AppConfig>(config);

  // 2. Dio client (baseUrl + timeout + logging)
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  // 3. AppHttpClient
  getIt.registerLazySingleton<AppHttpClient>(() => AppHttpClient(dio));

  // 4. Remote DataSource
  getIt.registerLazySingleton<GithubUserRemoteDataSource>(
    () => GithubUserRemoteDataSourceImpl(getIt<AppHttpClient>()),
  );

  // 5. Repository
  getIt.registerLazySingleton<GithubUserRepository>(
    () => config.useMockRepo
        ? GithubUserRepositoryMock()
        : GithubUserRepositoryImpl(getIt<GithubUserRemoteDataSource>()),
  );

  // 6. UseCase
  getIt.registerLazySingleton<GetUsers>(
    () => GetUsers(getIt<GithubUserRepository>()),
  );

  // 7. Cubit
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<GithubUserRepository>()),
  );
}
