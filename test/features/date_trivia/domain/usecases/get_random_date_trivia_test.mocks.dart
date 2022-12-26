// Mocks generated by Mockito 5.3.2 from annotations
// in number_trivia_app/test/features/date_trivia/domain/usecases/get_random_date_trivia_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_app/core/core.dart' as _i5;
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart' as _i3;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DateTriviaRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaRepository extends _i1.Mock
    implements _i3.DateTriviaRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>> getDateTrivia({
    required int? month,
    required int? day,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDateTrivia,
          [],
          {
            #month: month,
            #day: day,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>.value(
            _FakeEither_0<_i5.Failure, _i3.DateTrivia>(
          this,
          Invocation.method(
            #getDateTrivia,
            [],
            {
              #month: month,
              #day: day,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>.value(
                _FakeEither_0<_i5.Failure, _i3.DateTrivia>(
          this,
          Invocation.method(
            #getDateTrivia,
            [],
            {
              #month: month,
              #day: day,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>> getRandomDateTrivia() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRandomDateTrivia,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>.value(
            _FakeEither_0<_i5.Failure, _i3.DateTrivia>(
          this,
          Invocation.method(
            #getRandomDateTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>.value(
                _FakeEither_0<_i5.Failure, _i3.DateTrivia>(
          this,
          Invocation.method(
            #getRandomDateTrivia,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i3.DateTrivia>>);
  @override
  _i4.Future<void> addDateTriviaToFavorites(_i3.DateTrivia? dateTrivia) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDateTriviaToFavorites,
          [dateTrivia],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
