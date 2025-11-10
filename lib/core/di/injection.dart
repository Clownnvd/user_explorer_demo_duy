// final sl = GetIt.instance;
//
// Future<void> initDependencies(String baseUrl) async {
//   sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: baseUrl)));
//   sl.registerLazySingleton<AppHttpClient>(() => AppHttpClient(sl<Dio>()));
//
//   sl.registerLazySingleton<GithubUserRemoteDataSource>(
//     () => GithubUserRemoteDataSourceImpl(sl<AppHttpClient>()),
//   );
//
//   sl.registerLazySingleton<GithubUserRepository>(
//     () => GithubUserRepositoryImpl(sl<GithubUserRemoteDataSource>()),
//   );
//
//   sl.registerLazySingleton<GetUsers>(
//       () => GetUsers(sl<GithubUserRepository>()));
// }
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
  // 1. config
  getIt.registerSingleton<AppConfig>(config);

  // 2. Dio client (cấu hình baseUrl, timeout, interceptor logging)
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));

  // 3. AppHttpClient
  getIt.registerLazySingleton<AppHttpClient>(() => AppHttpClient(dio));

  // 4. Remote data source
  getIt.registerLazySingleton<GithubUserRemoteDataSource>(
    () => GithubUserRemoteDataSourceImpl(getIt<AppHttpClient>()),
  );

  // 5. Repository (chuyển qua mock hoặc thật tùy config)
  getIt.registerLazySingleton<GithubUserRepository>(
    () => config.useMockRepo
        ? GithubUserRepositoryMock()
        : GithubUserRepositoryImpl(getIt<GithubUserRemoteDataSource>()),
  );

  // 6. Use case
  getIt.registerLazySingleton<GetUsers>(
    () => GetUsers(getIt<GithubUserRepository>()),
  );

  // 7. Cubit
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<GetUsers>()),
  );
}
