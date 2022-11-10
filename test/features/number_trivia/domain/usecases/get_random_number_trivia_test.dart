import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const testNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get random trivia from the repository',
    () async {
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final result = await usecase(NoParams());

      expect(result, const Right(testNumberTrivia));

      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
