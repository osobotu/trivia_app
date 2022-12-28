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
          const testDateTrivia =
              DateTrivia(text: 'test text', number: 61, year: 2022);

          // mock input converter setup
          void setUpMockInputConverterSuccess() =>
              when(mockInputConverter.getMonthAndDayFromDateTime(any))
                  .thenReturn(Right(testDateParams));

          void setUpMockInputConverterFailure() =>
              when(mockInputConverter.getMonthAndDayFromDateTime(any))
                  .thenReturn(
                Left(InvalidInputFailure()),
              );

          // mock GetTriviaForConcreteDate setup
          void setUpMockGetTriviaForConcreteDateSuccess() =>
              when(mockGetConcreteDateTrivia(any))
                  .thenAnswer((_) async => const Right(testDateTrivia));

          blocTest(
            'should call InputConverter to validate and convert DateTime to DateParams',
            setUp: () {
              setUpMockInputConverterSuccess();
              setUpMockGetTriviaForConcreteDateSuccess();
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
              setUpMockInputConverterFailure();
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            expect: () => [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
          );

          blocTest(
            'should get data from the concrete use case',
            setUp: () {
              setUpMockInputConverterSuccess();
              setUpMockGetTriviaForConcreteDateSuccess();
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            verify: (_) {
              verify(mockGetConcreteDateTrivia(any)).called(1);
            },
          );

          blocTest(
            'should emit [Loading, Loaded] when data is gotten successfully',
            setUp: () {
              setUpMockInputConverterSuccess();
              setUpMockGetTriviaForConcreteDateSuccess();
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            expect: () => [
              Loading(),
              Loaded(trivia: testDateTrivia),
            ],
          );

          blocTest(
            'should emit [Loading, Error] when data is not gotten',
            setUp: () {
              setUpMockInputConverterSuccess();
              when(mockGetConcreteDateTrivia(any)).thenAnswer(
                (_) async => Left(ServerFailure()),
              );
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            expect: () => [
              Loading(),
              Error(message: SERVER_FAILURE_MESSAGE),
            ],
          );

          blocTest(
            'should emit [Loading, Error] with proper message when data is not gotten',
            setUp: () {
              setUpMockInputConverterSuccess();
              when(mockGetConcreteDateTrivia(any)).thenAnswer(
                (_) async => Left(CacheFailure()),
              );
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForConcreteDate(testDateTime)),
            expect: () => [
              Loading(),
              Error(message: CACHE_FAILURE_MESSAGE),
            ],
          );
        },
      );

      group(
        'GetTriviaForRandomDate',
        () {
          const testDateTrivia =
              DateTrivia(text: 'test text', number: 61, year: 2022);

          // mock GetTriviaForConcreteDate setup
          void setUpMockGetTriviaForRandomDateSuccess() =>
              when(mockGetRandomDateTrivia(any))
                  .thenAnswer((_) async => const Right(testDateTrivia));

          blocTest(
            'should get data from the random use case',
            setUp: () {
              setUpMockGetTriviaForRandomDateSuccess();
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomDate()),
            verify: (_) {
              verify(mockGetRandomDateTrivia(any)).called(1);
            },
          );

          blocTest(
            'should emit [Loading, Loaded] when data is gotten successfully',
            setUp: () {
              setUpMockGetTriviaForRandomDateSuccess();
              when(mockGetRandomDateTrivia(any))
                  .thenAnswer((_) async => const Right(testDateTrivia));
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomDate()),
            expect: () => [
              Loading(),
              Loaded(trivia: testDateTrivia),
            ],
          );

          blocTest(
            'should emit [Loading, Error] when data is not gotten',
            setUp: () {
              when(mockGetRandomDateTrivia(any)).thenAnswer(
                (_) async => Left(ServerFailure()),
              );
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomDate()),
            expect: () => [
              Loading(),
              Error(message: SERVER_FAILURE_MESSAGE),
            ],
          );

          blocTest(
            'should emit [Loading, Error] with proper message when data is not gotten',
            setUp: () {
              when(mockGetRandomDateTrivia(any)).thenAnswer(
                (_) async => Left(CacheFailure()),
              );
            },
            build: () => dateTriviaBloc,
            act: (bloc) => bloc.add(GetTriviaForRandomDate()),
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
