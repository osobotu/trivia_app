import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteNumberTriviaLocalDataSource>()])
import 'favorite_number_trivia_repository_impl_test.mocks.dart';

void main() {
  late FavoriteNumberTriviaRepository repository;
  late MockFavoriteNumberTriviaLocalDataSource
      mockFavoriteNumberTriviaLocalDataSource;

  setUp(() {
    mockFavoriteNumberTriviaLocalDataSource =
        MockFavoriteNumberTriviaLocalDataSource();
    repository = FavoriteNumberTriviaRepositoryImpl(
        localDataSource: mockFavoriteNumberTriviaLocalDataSource);
  });

  const noFavoritesList = <FavoriteNumberTriviaModel>[];
  const testId = '1';
  final testFavoriteNumberTriviaModel = FavoriteNumberTriviaModel(
    createdAt: DateTime(2023),
    number: 1,
    text: 'Test Text',
    id: testId,
  );

  final savedFavorites = [testFavoriteNumberTriviaModel];

  group(
    'FavoriteNumberTriviaRepositoryImpl',
    () {
      group(
        'getFavoriteNumber',
        () {
          test(
            'should return an empty list if user has no favorites ',
            () async {
              when(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .thenAnswer((_) async => noFavoritesList);

              final result = await repository.getFavoriteNumberTrivia();

              verify(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .called(1);

              expect(result, const Right(noFavoritesList));

              verifyNoMoreInteractions(mockFavoriteNumberTriviaLocalDataSource);
            },
          );

          test(
            'should return a List<FavoriteTrivia> when the user has favorites ',
            () async {
              when(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .thenAnswer((_) async => savedFavorites);

              final result = await repository.getFavoriteNumberTrivia();

              verify(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .called(1);

              expect(result, Right(savedFavorites));
            },
          );

          test(
            'should return a [CacheFailure] if call fails to get saved data',
            () async {
              when(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .thenThrow(CacheException());

              final result = await repository.getFavoriteNumberTrivia();

              verify(mockFavoriteNumberTriviaLocalDataSource
                      .getFavoriteNumberTrivia())
                  .called(1);

              expect(result, Left(CacheFailure()));
            },
          );
        },
      );

      group(
        'removeFavoriteNumberTrivia',
        () {
          test(
            'should return a [CacheFailure] if no FavoriteNumberModel exists for id given',
            () async {
              when(mockFavoriteNumberTriviaLocalDataSource
                      .removeFavoriteNumberTrivia(any))
                  .thenThrow(CacheException());

              final result =
                  await repository.removeFavoriteNumberTrivia(testId);

              expect(result, Left(CacheFailure()));
            },
          );

          test(
            'should return the removed FavoriteTriviaModel if the removal was successful ',
            () async {
              when(mockFavoriteNumberTriviaLocalDataSource
                      .removeFavoriteNumberTrivia(any))
                  .thenAnswer((_) async => testFavoriteNumberTriviaModel);

              final result =
                  await repository.removeFavoriteNumberTrivia(testId);

              verify(mockFavoriteNumberTriviaLocalDataSource
                      .removeFavoriteNumberTrivia(any))
                  .called(1);

              expect(result, Right(testFavoriteNumberTriviaModel));
            },
          );
        },
      );
    },
  );
}
