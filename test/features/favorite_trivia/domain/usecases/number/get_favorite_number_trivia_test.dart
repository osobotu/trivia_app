import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteNumberTriviaRepository>()])
import 'get_favorite_number_trivia_test.mocks.dart';

void main() {
  late GetFavoriteNumberTrivia usecase;
  late MockFavoriteNumberTriviaRepository mockFavoriteNumberTriviaRepository;

  setUp(
    () {
      mockFavoriteNumberTriviaRepository = MockFavoriteNumberTriviaRepository();
      usecase = GetFavoriteNumberTrivia(mockFavoriteNumberTriviaRepository);
    },
  );

  final testFavoriteNumberTrivia = FavoriteNumberTrivia(
      createdAt: DateTime.now(), number: 1, text: 'Test Text', id: 'id');
  final testList = [testFavoriteNumberTrivia];

  test(
    'should get a List<FavoriteNumberTrivia> when called',
    () async {
      when(mockFavoriteNumberTriviaRepository.getFavoriteNumberTrivia())
          .thenAnswer((_) async => Right(testList));

      final result = await usecase(NoParams());

      expect(result, Right(testList));

      verify(mockFavoriteNumberTriviaRepository.getFavoriteNumberTrivia());

      verifyNoMoreInteractions(mockFavoriteNumberTriviaRepository);
    },
  );
}
