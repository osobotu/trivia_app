import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  await initExternalDependencies();
  await initCoreDependencies();

  //! Features
  await initNumberTriviaDependencies();
  await initDateTriviaDependencies();
}

// * * Features
//! Number Trivia
Future<void> initNumberTriviaDependencies() async {
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

//! Date Trivia
Future<void> initDateTriviaDependencies() async {
  // Bloc
  sl.registerFactory(
    () => DateTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteDateTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomDateTrivia(sl()));

  // Repository
  sl.registerLazySingleton<DateTriviaRepository>(
    () => DateTriviaRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DateTriviaRemoteDataSource>(
    () => DateTriviaRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DateTriviaLocalDataSource>(
    () => DateTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

//! Core
Future<void> initCoreDependencies() async {
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
}

//! External
Future<void> initExternalDependencies() async {
  sl.registerLazySingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
