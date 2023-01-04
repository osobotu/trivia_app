import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/favorite_trivia/domain/usecases/date/remove_favorite_date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteDateTriviaRepository>()])
import 'remove_favorite_date_trivia_test.mocks.dart';

void main() {
  late RemoveFavoriteDateTrivia usecase;
  late MockFavoriteDateTriviaRepository mockFavoriteDateTriviaRepository;

  setUp(
    () {
      mockFavoriteDateTriviaRepository = MockFavoriteDateTriviaRepository();
      usecase = RemoveFavoriteDateTrivia(mockFavoriteDateTriviaRepository);
    },
  );
  const testId = '1';
  final testFavoriteDateTrivia = FavoriteDateTrivia(
    createdAt: DateTime.now(),
    number: 1,
    text: "Test Text",
    year: 2023,
  );

  test(
    'should return a FavoriteDateTrivia after successful removal',
    () async {
      when(mockFavoriteDateTriviaRepository.removeFavoriteDateTrivia(testId))
          .thenAnswer(
        (_) async => Right(testFavoriteDateTrivia),
      );

      final result = await usecase(const Params(id: testId));

      expect(result, Right(testFavoriteDateTrivia));

      verify(mockFavoriteDateTriviaRepository.removeFavoriteDateTrivia(any));
      verifyNoMoreInteractions(mockFavoriteDateTriviaRepository);
    },
  );
}
