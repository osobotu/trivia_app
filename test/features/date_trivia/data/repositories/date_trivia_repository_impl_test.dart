import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

@GenerateNiceMocks([
  MockSpec<DateTriviaRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
  MockSpec<DateTriviaLocalDataSource>()
])
import 'date_trivia_repository_impl_test.mocks.dart';

void main() {
  late DateTriviaRepositoryImpl repository;
  late MockDateTriviaRemoteDataSource mockDateTriviaRemoteDataSource;
  late MockDateTriviaLocalDataSource mockDateTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDateTriviaRemoteDataSource = MockDateTriviaRemoteDataSource();
    mockDateTriviaLocalDataSource = MockDateTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = DateTriviaRepositoryImpl(
      remoteDataSource: mockDateTriviaRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockDateTriviaLocalDataSource,
    );
  });

  /// Set up the test variables that will be used through out the testing
  const testMonth = 11;
  const testDay = 04;
  const testText = 'Test Text';
  const testNumber = 61;
  const testYear = 2022;
  const testDateTriviaModel =
      DateTriviaModel(text: testText, number: testNumber, year: testYear);

  const DateTrivia testDateTrivia = testDateTriviaModel;

  runTestsOnline(Function body) {
    group(
      'device is online',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        body();
      },
    );
  }

  runTestsOffline(Function body) {
    group(
      'device is offline',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        body();
      },
    );
  }

  group(
    'getDateTrivia',
    () {
      test(
        'should check if the device is online',
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          repository.getDateTrivia(month: testMonth, day: testDay);

          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call to the remote data source is successful',
          () async {
            when(mockDateTriviaRemoteDataSource.getDateTrivia(
                    month: testMonth, day: testDay))
                .thenAnswer((_) async => testDateTriviaModel);

            final result =
                await repository.getDateTrivia(month: testMonth, day: testDay);

            verify(mockDateTriviaRemoteDataSource.getDateTrivia(
                month: testMonth, day: testDay));

            expect(result, const Right(testDateTrivia));
          },
        );

        test(
          'should cache the data locally when the call to the remote data source is successful',
          () async {
            when(mockDateTriviaRemoteDataSource.getDateTrivia(
                    month: testMonth, day: testDay))
                .thenAnswer((_) async => testDateTriviaModel);

            await repository.getDateTrivia(month: testMonth, day: testDay);

            verify(mockDateTriviaRemoteDataSource.getDateTrivia(
                month: testMonth, day: testDay));

            verify(mockDateTriviaLocalDataSource
                .cacheDateTrivia(testDateTriviaModel));
          },
        );

        test(
          'should return server failure when call to remote data source is unsuccessful',
          () async {
            when(mockDateTriviaRemoteDataSource.getDateTrivia(
                    month: testMonth, day: testDay))
                .thenThrow(ServerException());

            final result =
                await repository.getDateTrivia(month: testMonth, day: testDay);

            verify(mockDateTriviaRemoteDataSource.getDateTrivia(
                month: testMonth, day: testDay));
            verifyZeroInteractions(mockDateTriviaLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      runTestsOffline(() {
        test(
          'should return the last cached data is the cached data is present',
          () async {
            when(mockDateTriviaLocalDataSource.getLastDateTrivia())
                .thenAnswer((_) async => testDateTriviaModel);

            final result =
                await repository.getDateTrivia(month: testMonth, day: testDay);

            verifyZeroInteractions(mockDateTriviaRemoteDataSource);
            verify(mockDateTriviaLocalDataSource.getLastDateTrivia());
            expect(result, equals(const Right(testDateTriviaModel)));
          },
        );

        test(
          'should return [CacheFailure] when there is no cached data present',
          () async {
            when(mockDateTriviaLocalDataSource.getLastDateTrivia())
                .thenThrow(CacheException());

            final result =
                await repository.getDateTrivia(month: testMonth, day: testDay);

            verifyZeroInteractions(mockDateTriviaRemoteDataSource);
            verify(mockDateTriviaLocalDataSource.getLastDateTrivia());
            expect(
              result,
              equals(Left(CacheFailure())),
            );
          },
        );
      });
    },
  );
  group(
    'getRandomDateTrivia',
    () {
      test(
        'should check if the device is online',
        () {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          repository.getRandomDateTrivia();

          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call to the remote data source is successful',
          () async {
            when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
                .thenAnswer((_) async => testDateTriviaModel);

            final result = await repository.getRandomDateTrivia();

            verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());

            expect(result, const Right(testDateTrivia));
          },
        );

        test(
          'should cache the data locally when the call to the remote data source is successful',
          () async {
            when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
                .thenAnswer((_) async => testDateTriviaModel);

            await repository.getRandomDateTrivia();

            verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());

            verify(mockDateTriviaLocalDataSource
                .cacheDateTrivia(testDateTriviaModel));
          },
        );

        test(
          'should return server failure when call to remote data source is unsuccessful',
          () async {
            when(mockDateTriviaRemoteDataSource.getRandomDateTrivia())
                .thenThrow(ServerException());

            final result = await repository.getRandomDateTrivia();

            verify(mockDateTriviaRemoteDataSource.getRandomDateTrivia());
            verifyZeroInteractions(mockDateTriviaLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });

      runTestsOffline(() {
        test(
          'should return the last cached data is the cached data is present',
          () async {
            when(mockDateTriviaLocalDataSource.getLastDateTrivia())
                .thenAnswer((_) async => testDateTriviaModel);

            final result = await repository.getRandomDateTrivia();

            verifyZeroInteractions(mockDateTriviaRemoteDataSource);
            verify(mockDateTriviaLocalDataSource.getLastDateTrivia());
            expect(result, equals(const Right(testDateTriviaModel)));
          },
        );

        test(
          'should return [CacheFailure] when there is no cached data present',
          () async {
            when(mockDateTriviaLocalDataSource.getLastDateTrivia())
                .thenThrow(CacheException());

            final result = await repository.getRandomDateTrivia();

            verifyZeroInteractions(mockDateTriviaRemoteDataSource);
            verify(mockDateTriviaLocalDataSource.getLastDateTrivia());
            expect(
              result,
              equals(Left(CacheFailure())),
            );
          },
        );
      });
    },
  );
}
