import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/date_trivia/domain/usecases/get_date_trivia.dart';

@GenerateNiceMocks([MockSpec<DateTriviaRepository>()])
import 'get_date_trivia_test.mocks.dart';

void main() {
  late GetDateTrivia usecase;
  late MockDateTriviaRepository mockDateTriviaRepository;

  setUp(() {
    mockDateTriviaRepository = MockDateTriviaRepository();
    usecase = GetDateTrivia(mockDateTriviaRepository);
  });

  const testMonth = 10;
  const testDay = 13;
  const testDateTrivia = DateTrivia(text: 'test');

  test('should get a date trivia for the given date', () async {
    when(mockDateTriviaRepository.getDateTrivia(month: testMonth, day: testDay))
        .thenAnswer((_) async => const Right(testDateTrivia));

    final result = await usecase(Params(month: testMonth, day: testDay));

    expect(result, const Right(testDateTrivia));

    verify(
        mockDateTriviaRepository.getDateTrivia(month: testMonth, day: testDay));

    verifyNoMoreInteractions(mockDateTriviaRepository);
  });
}
