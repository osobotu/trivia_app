import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
  MockSpec<InputConverter>()
])
import 'number_trivia_bloc_test.mocks.dart';

void main() {
  late NumberTriviaBloc numberTriviaBloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(
    () {
      mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
      mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
      mockInputConverter = MockInputConverter();
      numberTriviaBloc = NumberTriviaBloc(
        concrete: mockGetConcreteNumberTrivia,
        random: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter,
      );
    },
  );

  tearDown(
    () {
      numberTriviaBloc.close();
    },
  );

  group(
    'NumberTriviaBloc',
    () {
      test('initial state is Empty', () {
        expect(numberTriviaBloc.state, Empty());
      });

      group(
        'GetTriviaForConcreteNumber',
        () {
          const testNumberString = '1';

          final testNumberParsed = int.parse(testNumberString);

          const testNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

          blocTest(
            'should call InputConverter to validate and convert'
            'the numberString to a positive unsigned integer',
            setUp: () {
              when(mockInputConverter.stringToUnsignedInteger(any))
                  .thenReturn(Right(testNumberParsed));
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            verify: (_) {
              verify(
                mockInputConverter.stringToUnsignedInteger(any),
              ).called(1);
            },
          );

          blocTest(
            'should emit [Error] when the input is invalid',
            setUp: () {
              when(mockInputConverter.stringToUnsignedInteger(any))
                  .thenReturn(Left(InvalidInputFailure()));
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            expect: () => [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
          );
        },
      );
    },
  );
}
