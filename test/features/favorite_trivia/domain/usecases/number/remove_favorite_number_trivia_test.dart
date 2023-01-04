import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteNumberTriviaRepository>()])
import 'remove_favorite_number_trivia_test.mocks.dart';

void main() {
  late RemoveFavoriteNumberTrivia usecase;
  late MockFavoriteNumberTriviaRepository mockFavoriteNumberTriviaRepository;

  setUp(() {
    mockFavoriteNumberTriviaRepository = MockFavoriteNumberTriviaRepository();
    usecase = RemoveFavoriteNumberTrivia(mockFavoriteNumberTriviaRepository);
  });
  const testId = '1';
  final testFavoriteNumberTrivia = FavoriteNumberTrivia(
    createdAt: DateTime.now(),
    number: 1,
    text: "Test Text",
  );

  test(
    'should call repository to remove FavoriteNumberTrivia with given id',
    () async {
      when(mockFavoriteNumberTriviaRepository.removeFavoriteNumberTrivia(any))
          .thenAnswer((_) async => Right(testFavoriteNumberTrivia));

      final result = await usecase(const Params(id: testId));

      expect(result, Right(testFavoriteNumberTrivia));

      verify(
          mockFavoriteNumberTriviaRepository.removeFavoriteNumberTrivia(any));

      verifyNoMoreInteractions(mockFavoriteNumberTriviaRepository);
    },
  );
}
