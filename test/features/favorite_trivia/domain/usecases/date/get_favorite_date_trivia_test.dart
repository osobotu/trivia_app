import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

@GenerateNiceMocks([MockSpec<FavoriteDateTriviaRepository>()])
import 'get_favorite_date_trivia_test.mocks.dart';

void main() {
  late GetFavoriteDateTrivia usecase;
  late MockFavoriteDateTriviaRepository mockFavoriteDateTriviaRepository;

  setUp(() {
    mockFavoriteDateTriviaRepository = MockFavoriteDateTriviaRepository();
    usecase = GetFavoriteDateTrivia(mockFavoriteDateTriviaRepository);
  });

  final testFavoriteDateTrivia = FavoriteDateTrivia(
    createdAt: DateTime.now(),
    number: 1,
    text: 'Test Text',
    year: 2022,
  );
  final testList = [testFavoriteDateTrivia];
  test(
    'should get a List<FavoriteDateTrivia> when called',
    () async {
      when(mockFavoriteDateTriviaRepository.getFavoriteDateTrivia()).thenAnswer(
        (_) async => Right(testList),
      );

      final result = await usecase(NoParams());

      expect(result, Right(testList));

      verify(mockFavoriteDateTriviaRepository.getFavoriteDateTrivia());

      verifyNoMoreInteractions(mockFavoriteDateTriviaRepository);
    },
  );
}
