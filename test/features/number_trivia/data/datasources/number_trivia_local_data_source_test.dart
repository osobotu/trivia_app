import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'number_trivia_local_data_source_test.mocks.dart';

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture('trivia_cached.json')));

    test(
      'should return a NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));

        final result = await dataSource.getLastNumberTrivia();

        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(testNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when there is no value cached',
      () {
        when(mockSharedPreferences.getString(any));

        final call = dataSource.getLastNumberTrivia;

        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group(
    'cacheNumberTrivia',
    () {
      const testNumberTriviaModel =
          NumberTriviaModel(number: 1, text: 'Test Text');

      test(
        'should call SharedPreferences to cache the data',
        () {
          dataSource.cacheNumberTrivia(testNumberTriviaModel);

          final expectedJsonString = jsonEncode(testNumberTriviaModel.toJson());

          verify(
            mockSharedPreferences.setString(
                CACHED_NUMBER_TRIVIA, expectedJsonString),
          );
        },
      );
    },
  );
}
