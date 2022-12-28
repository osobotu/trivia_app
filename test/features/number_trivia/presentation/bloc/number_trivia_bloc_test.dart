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

          // mock input converter setup
          void setUpMockInputConverterSuccess() =>
              when(mockInputConverter.stringToUnsignedInteger(any))
                  .thenReturn(Right(testNumberParsed));

          void setUpMockInputConverterFailure() =>
              when(mockInputConverter.stringToUnsignedInteger(any))
                  .thenReturn(Left(InvalidInputFailure()));

          // mock GetTriviaForConcreteNumber set up
          void setMockGetTriviaForConcreteNumberSuccess() =>
              when(mockGetConcreteNumberTrivia(any)).thenAnswer(
                (_) async => const Right(testNumberTrivia),
              );

          blocTest(
            'should call InputConverter to validate and convert'
            'the numberString to a positive unsigned integer',
            setUp: () {
              setUpMockInputConverterSuccess();
              setMockGetTriviaForConcreteNumberSuccess();
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
              setUpMockInputConverterFailure();
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            expect: () => [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
          );

          blocTest(
            'should get data from the concrete use case',
            setUp: () {
              setUpMockInputConverterSuccess();
              setMockGetTriviaForConcreteNumberSuccess();
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            verify: (_) {
              verify(mockGetConcreteNumberTrivia(
                      Params(number: testNumberParsed)))
                  .called(1);
            },
          );

          blocTest(
            'should emit [Loading, Loaded] when data is gotten successfully',
            setUp: () {
              setUpMockInputConverterSuccess();
              setMockGetTriviaForConcreteNumberSuccess();
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            expect: () => [
              Loading(),
              Loaded(trivia: testNumberTrivia),
            ],
          );

          blocTest(
            'should emit [Loading, Error] when getting the number trivia was unsuccessful',
            setUp: () {
              setUpMockInputConverterSuccess();
              when(mockGetConcreteNumberTrivia(any)).thenAnswer(
                (_) async => Left(ServerFailure()),
              );
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            expect: () => [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
          );

          blocTest(
            'should emit [Loading, Error] with a proper error message when getting data fails',
            setUp: () {
              setUpMockInputConverterSuccess();
              when(mockGetConcreteNumberTrivia(any)).thenAnswer(
                (_) async => Left(CacheFailure()),
              );
            },
            build: () => numberTriviaBloc,
            act: (bloc) =>
                bloc.add(GetTriviaForConcreteNumber(testNumberString)),
            expect: () => [
              Loading(),
              Error(message: CACHE_FAILURE_MESSAGE),
            ],
          );
        },
      );

      group(
        'GetTriviaForRandomNumber',
        () {
          const testNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

          // mock GetTriviaForConcreteNumber set up
          void setMockGetTriviaForRandomNumberSuccess() =>
              when(mockGetRandomNumberTrivia(any)).thenAnswer(
                (_) async => const Right(testNumberTrivia),
              );

          blocTest(
            'should get data from the random use case',
            setUp: () {
              setMockGetTriviaForRandomNumberSuccess();
            },
            build: () => numberTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
            verify: (_) {
              verify(
                mockGetRandomNumberTrivia(NoParams()),
              ).called(1);
            },
          );

          blocTest(
            'should emit [Loading, Loaded] when data is gotten successfully',
            setUp: () {
              setMockGetTriviaForRandomNumberSuccess();
            },
            build: () => numberTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
            expect: () => [
              Loading(),
              Loaded(trivia: testNumberTrivia),
            ],
          );

          blocTest(
            'should emit [Loading, Error] when getting the number trivia was unsuccessful',
            setUp: () {
              when(mockGetRandomNumberTrivia(any)).thenAnswer(
                (_) async => Left(ServerFailure()),
              );
            },
            build: () => numberTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
            expect: () => [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
          );

          blocTest(
            'should emit [Loading, Error] with a proper error message when getting data fails',
            setUp: () {
              when(mockGetRandomNumberTrivia(any)).thenAnswer(
                (_) async => Left(CacheFailure()),
              );
            },
            build: () => numberTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
            expect: () => [
              Loading(),
              Error(message: CACHE_FAILURE_MESSAGE),
            ],
          );
        },
      );
    },
  );
}
