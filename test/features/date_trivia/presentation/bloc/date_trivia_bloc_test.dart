import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/date_trivia/presentation/bloc/date_trivia_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteDateTrivia>(),
  MockSpec<GetRandomDateTrivia>(),
  MockSpec<InputConverter>(),
])
import 'date_trivia_bloc_test.mocks.dart';

void main() {
  late DateTriviaBloc dateTriviaBloc;
  late MockGetConcreteDateTrivia mockGetConcreteDateTrivia;
  late MockGetRandomDateTrivia mockGetRandomDateTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteDateTrivia = MockGetConcreteDateTrivia();
    mockGetRandomDateTrivia = MockGetRandomDateTrivia();
    mockInputConverter = MockInputConverter();
    dateTriviaBloc = DateTriviaBloc(
        concrete: mockGetConcreteDateTrivia,
        random: mockGetRandomDateTrivia,
        inputConverter: mockInputConverter);
  });

  tearDown(() {
    dateTriviaBloc.close();
  });

  group(
    'DateTriviaBloc',
    () {
      test(
        'initial state is Empty',
        () {
          expect(dateTriviaBloc.state, Empty());
        },
      );

      group(
        'GetTriviaForConcreteDate',
        () {
          final testDateTime = DateTime.now();
          final testDateParams = DateParams(month: 12, day: 28);

          blocTest(
            'should call InputConverter to validate and convert DateTime to DateParams',
            setUp: () {
              when(mockInputConverter.getMonthAndDayFromDateTime(any))
                  .thenReturn(Right(testDateParams));
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            verify: (_) {
              verify(mockInputConverter.getMonthAndDayFromDateTime(any))
                  .called(1);
            },
          );

          blocTest(
            'should emit [Error] when the input is invalid',
            setUp: () {
              when(mockInputConverter.getMonthAndDayFromDateTime(any))
                  .thenReturn(
                Left(InvalidInputFailure()),
              );
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            expect: () => [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
          );
        },
      );
    },
  );
}
