import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';

import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteDateTriviaLocalDataSource>()])
import 'favorite_date_trivia_repository_impl_test.mocks.dart';

void main() {
  late FavoriteDateTriviaRepository repository;
  late MockFavoriteDateTriviaLocalDataSource
      mockFavoriteDateTriviaLocalDataSource;

  setUp(() {
    mockFavoriteDateTriviaLocalDataSource =
        MockFavoriteDateTriviaLocalDataSource();
    repository = FavoriteDateTriviaRepositoryImpl(
        localDataSource: mockFavoriteDateTriviaLocalDataSource);
  });

  const noFavoritesList = <FavoriteDateTriviaModel>[];
  const testId = '1';
  final testFavoriteDateTriviaModel = FavoriteDateTriviaModel(
    createdAt: DateTime(2023),
    number: 1,
    text: 'Test Text',
    year: 2023,
    id: testId,
  );
  final savedFavorites = [testFavoriteDateTriviaModel];

  group(
    'getFavoriteDateTrivia',
    () {
      test(
        'should return an empty list if user has no favorites added',
        () async {
          when(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .thenAnswer((_) async => noFavoritesList);

          final result = await repository.getFavoriteDateTrivia();
          verify(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .called(1);

          expect(result, const Right(noFavoritesList));
        },
      );

      test(
        'should return a List<FavoriteTrivia> if user has favorites',
        () async {
          when(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .thenAnswer((_) async => savedFavorites);

          final result = await repository.getFavoriteDateTrivia();
          verify(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .called(1);

          expect(result, equals(Right(savedFavorites)));
        },
      );

      test(
        'should return a [Cache Failure] if call fails to get saved data',
        () async {
          when(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .thenThrow(CacheException());

          final result = await repository.getFavoriteDateTrivia();

          verify(mockFavoriteDateTriviaLocalDataSource.getFavoriteDateTrivia())
              .called(1);

          expect(
            result,
            Left(CacheFailure()),
          );
        },
      );
    },
  );

  group(
    'removeFavoriteDateTrivia',
    () {
      test(
        'should return a [CacheException] if FavoriteDateTrivia with given id does not exist',
        () async {
          when(mockFavoriteDateTriviaLocalDataSource
                  .removeFavoriteDateTrivia(testId))
              .thenThrow(CacheException());

          final result = await repository.removeFavoriteDateTrivia(testId);
          verify(mockFavoriteDateTriviaLocalDataSource
                  .removeFavoriteDateTrivia(any))
              .called(1);
          expect(
            result,
            Left(CacheFailure()),
          );
        },
      );

      test(
        'should return the removed FavoriteTriviaModel if the removal was successful',
        () async {
          when(mockFavoriteDateTriviaLocalDataSource
                  .removeFavoriteDateTrivia(testId))
              .thenAnswer((_) async => testFavoriteDateTriviaModel);

          final result = await repository.removeFavoriteDateTrivia(testId);
          verify(mockFavoriteDateTriviaLocalDataSource
                  .removeFavoriteDateTrivia(any))
              .called(1);

          expect(result, Right(testFavoriteDateTriviaModel));
        },
      );
    },
  );
}
