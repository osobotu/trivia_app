import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

@GenerateNiceMocks([MockSpec<DateTriviaRepository>()])
import 'get_random_date_trivia_test.mocks.dart';

void main() {
  late GetRandomDateTrivia usecase;
  late MockDateTriviaRepository mockDateTriviaRepository;

  setUp(() {
    mockDateTriviaRepository = MockDateTriviaRepository();
    usecase = GetRandomDateTrivia(mockDateTriviaRepository);
  });

  const testMonth = 10;
  const testDay = 13;

  const testDateTrivia = DateTrivia(text: 'Test', number: 61, year: 1954);

  test('should get a fact for a random date', () async {
    when(mockDateTriviaRepository.getRandomDateTrivia())
        .thenAnswer((_) async => const Right(testDateTrivia));

    final result = await usecase(NoParams());

    expect(result, const Right(testDateTrivia));

    verify(mockDateTriviaRepository.getRandomDateTrivia());

    verifyNoMoreInteractions(mockDateTriviaRepository);
  });
}
