// Mocks generated by Mockito 5.3.2 from annotations
// in number_trivia_app/test/features/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_app/core/core.dart' as _i5;
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart' as _i6;
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart'
    as _i7;
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNumberTriviaRepository_0 extends _i1.SmartFake
    implements _i2.NumberTriviaRepository {
  _FakeNumberTriviaRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetConcreteNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTrivia extends _i1.Mock
    implements _i2.GetConcreteNumberTrivia {
  @override
  _i2.NumberTriviaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.NumberTriviaRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>> call(
          _i2.Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>.value(
                _FakeEither_1<_i5.Failure, _i2.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>.value(
                _FakeEither_1<_i5.Failure, _i2.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>);
}

/// A class which mocks [GetRandomNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTrivia extends _i1.Mock
    implements _i2.GetRandomNumberTrivia {
  @override
  _i2.NumberTriviaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeNumberTriviaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.NumberTriviaRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>> call(
          _i5.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>.value(
                _FakeEither_1<_i5.Failure, _i2.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>.value(
                _FakeEither_1<_i5.Failure, _i2.NumberTrivia>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, _i2.NumberTrivia>>);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i5.InputConverter {
  @override
  _i3.Either<_i5.Failure, int> stringToUnsignedInteger(String? str) =>
      (super.noSuchMethod(
        Invocation.method(
          #stringToUnsignedInteger,
          [str],
        ),
        returnValue: _FakeEither_1<_i5.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i5.Failure, int>(
          this,
          Invocation.method(
            #stringToUnsignedInteger,
            [str],
          ),
        ),
      ) as _i3.Either<_i5.Failure, int>);
  @override
  _i3.Either<_i5.Failure, _i6.DateParams> getMonthAndDayFromDateTime(
          DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMonthAndDayFromDateTime,
          [date],
        ),
        returnValue: _FakeEither_1<_i5.Failure, _i6.DateParams>(
          this,
          Invocation.method(
            #getMonthAndDayFromDateTime,
            [date],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i5.Failure, _i6.DateParams>(
          this,
          Invocation.method(
            #getMonthAndDayFromDateTime,
            [date],
          ),
        ),
      ) as _i3.Either<_i5.Failure, _i6.DateParams>);
  @override
  _i3.Either<_i5.Failure, _i7.FavoriteDateTrivia> triviaToFavoriteDate(
          _i6.DateTrivia? dateTrivia) =>
      (super.noSuchMethod(
        Invocation.method(
          #triviaToFavoriteDate,
          [dateTrivia],
        ),
        returnValue: _FakeEither_1<_i5.Failure, _i7.FavoriteDateTrivia>(
          this,
          Invocation.method(
            #triviaToFavoriteDate,
            [dateTrivia],
          ),
        ),
        returnValueForMissingStub:
            _FakeEither_1<_i5.Failure, _i7.FavoriteDateTrivia>(
          this,
          Invocation.method(
            #triviaToFavoriteDate,
            [dateTrivia],
          ),
        ),
      ) as _i3.Either<_i5.Failure, _i7.FavoriteDateTrivia>);
  @override
  _i3.Either<_i5.Failure, _i7.FavoriteNumberTrivia> triviaToFavoriteNumber(
          _i2.NumberTrivia? numberTrivia) =>
      (super.noSuchMethod(
        Invocation.method(
          #triviaToFavoriteNumber,
          [numberTrivia],
        ),
        returnValue: _FakeEither_1<_i5.Failure, _i7.FavoriteNumberTrivia>(
          this,
          Invocation.method(
            #triviaToFavoriteNumber,
            [numberTrivia],
          ),
        ),
        returnValueForMissingStub:
            _FakeEither_1<_i5.Failure, _i7.FavoriteNumberTrivia>(
          this,
          Invocation.method(
            #triviaToFavoriteNumber,
            [numberTrivia],
          ),
        ),
      ) as _i3.Either<_i5.Failure, _i7.FavoriteNumberTrivia>);
}
