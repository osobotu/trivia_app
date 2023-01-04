// Mocks generated by Mockito 5.3.2 from annotations
// in number_trivia_app/test/features/date_trivia/data/repositories/date_trivia_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_app/core/core.dart' as _i4;
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart' as _i2;

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

class _FakeDateTriviaModel_0 extends _i1.SmartFake
    implements _i2.DateTriviaModel {
  _FakeDateTriviaModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DateTriviaRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaRemoteDataSource extends _i1.Mock
    implements _i2.DateTriviaRemoteDataSource {
  @override
  _i3.Future<_i2.DateTriviaModel> getDateTrivia({
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
        returnValue:
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
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
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
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
      ) as _i3.Future<_i2.DateTriviaModel>);
  @override
  _i3.Future<_i2.DateTriviaModel> getRandomDateTrivia() => (super.noSuchMethod(
        Invocation.method(
          #getRandomDateTrivia,
          [],
        ),
        returnValue:
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
          this,
          Invocation.method(
            #getRandomDateTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
          this,
          Invocation.method(
            #getRandomDateTrivia,
            [],
          ),
        )),
      ) as _i3.Future<_i2.DateTriviaModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [DateTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaLocalDataSource extends _i1.Mock
    implements _i2.DateTriviaLocalDataSource {
  @override
  _i3.Future<_i2.DateTriviaModel> getLastDateTrivia() => (super.noSuchMethod(
        Invocation.method(
          #getLastDateTrivia,
          [],
        ),
        returnValue:
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
          this,
          Invocation.method(
            #getLastDateTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.DateTriviaModel>.value(_FakeDateTriviaModel_0(
          this,
          Invocation.method(
            #getLastDateTrivia,
            [],
          ),
        )),
      ) as _i3.Future<_i2.DateTriviaModel>);
  @override
  _i3.Future<void> cacheDateTrivia(_i2.DateTriviaModel? triviaToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheDateTrivia,
          [triviaToCache],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> addDateTriviaToFavorites(_i2.DateTriviaModel? dateTrivia) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDateTriviaToFavorites,
          [dateTrivia],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
