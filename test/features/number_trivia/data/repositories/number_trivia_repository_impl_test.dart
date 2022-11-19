import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
import 'number_trivia_repository_impl_test.mocks.dart';

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  setUp(() {
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      localDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  /// Data for the mocks and assertions
  /// We'll use these three variables throughout all the tests
  ///
  const testNumber = 1;
  const testText = 'Test Text';
  const testNumberTriviaModel =
      NumberTriviaModel(text: testText, number: testNumber);
  const NumberTrivia testNumberTrivia = testNumberTriviaModel;

  group(
    'getConcreteNumberTrivia',
    () {
      test(
        'should check if the device is online',
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          repository.getConcreteNumberTrivia(testNumber);
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockNumberTriviaRemoteDataSource
                      .getConcreteNumberTrivia(testNumber))
                  .thenAnswer((_) async => testNumberTriviaModel);

              final result =
                  await repository.getConcreteNumberTrivia(testNumber);

              verify(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(testNumber));
              expect(result, equals(const Right(testNumberTrivia)));
            },
          );

          test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
              when(mockNumberTriviaRemoteDataSource
                      .getConcreteNumberTrivia(testNumber))
                  .thenAnswer((_) async => testNumberTriviaModel);

              await repository.getConcreteNumberTrivia(testNumber);

              verify(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(testNumber));
              verify(mockNumberTriviaLocalDataSource
                  .cacheNumberTrivia(testNumberTriviaModel));
            },
          );

          test(
            'should return [ServerFailure] when the call to the remote data source is unsuccessful',
            () async {
              when(mockNumberTriviaRemoteDataSource
                      .getConcreteNumberTrivia(testNumber))
                  .thenThrow(ServerException());

              final result =
                  await repository.getConcreteNumberTrivia(testNumber);

              verify(mockNumberTriviaRemoteDataSource
                  .getConcreteNumberTrivia(testNumber));
              verifyZeroInteractions(mockNumberTriviaLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          test(
            'should return last locally cached data when the cached data is present',
            () async {
              when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
                  .thenAnswer((_) async => testNumberTriviaModel);

              final result =
                  await repository.getConcreteNumberTrivia(testNumber);

              verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
              verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
              expect(result, equals(const Right(testNumberTrivia)));
            },
          );

          test(
            'should return [CacheFailure] when there is no cached data present',
            () async {
              when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
                  .thenThrow(CacheException());

              final result =
                  await repository.getConcreteNumberTrivia(testNumber);

              verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
              verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
              expect(
                result,
                equals(Left(CacheFailure())),
              );
            },
          );
        },
      );
    },
  );

  group(
    'getRandomNumberTrivia',
    () {
      test(
        'should check if the device is online',
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          repository.getRandomNumberTrivia();
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
                  .thenAnswer((_) async => testNumberTriviaModel);

              final result = await repository.getRandomNumberTrivia();

              verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
              expect(result, equals(const Right(testNumberTrivia)));
            },
          );

          test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
              when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
                  .thenAnswer((_) async => testNumberTriviaModel);

              await repository.getRandomNumberTrivia();

              verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
              verify(mockNumberTriviaLocalDataSource
                  .cacheNumberTrivia(testNumberTriviaModel));
            },
          );

          test(
            'should return [ServerFailure] when the call to the remote data source is unsuccessful',
            () async {
              when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
                  .thenThrow(ServerException());

              final result = await repository.getRandomNumberTrivia();

              verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
              verifyZeroInteractions(mockNumberTriviaLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          test(
            'should return last locally cached data when the cached data is present',
            () async {
              when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
                  .thenAnswer((_) async => testNumberTriviaModel);

              final result = await repository.getRandomNumberTrivia();

              verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
              verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
              expect(result, equals(const Right(testNumberTrivia)));
            },
          );

          test(
            'should return [CacheFailure] when there is no cached data present',
            () async {
              when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
                  .thenThrow(CacheException());

              final result = await repository.getRandomNumberTrivia();

              verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
              verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
              expect(result, equals(Left(CacheFailure())));
            },
          );
        },
      );
    },
  );
}
