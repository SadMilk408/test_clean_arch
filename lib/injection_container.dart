import 'package:clean_arch/core/util/input_converter.dart';
import 'package:clean_arch/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'features/users_list/data/repositories/users_list_repository_impl.dart';
import 'features/users_list/domain/repositories/users_list_repository.dart';
import 'features/users_list/domain/usecases/get_users_list.dart';
import 'features/users_list/presentation/bloc/users_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  /// Features - Users List
  // Bloc
  sl.registerFactory(
    () => UsersListBloc(
      getUsersList: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUsersList(sl()));

  // Repository
  sl.registerLazySingleton<UsersListRepository>(
    () => UsersListRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UsersListRemoteDataSource>(
    () => UsersListRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<UsersListLocalDataSource>(
    () => UsersListLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}
