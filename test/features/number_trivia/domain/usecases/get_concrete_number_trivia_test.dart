import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const testNumber = 1;
  const testNumberTrivia = NumberTrivia(text: 'test', number: testNumber);

  test(
    'should get trivia for the number from the repository',
    () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(testNumberTrivia));

      final result = await usecase.execute(number: testNumber);

      expect(result, const Right(testNumberTrivia));

      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
