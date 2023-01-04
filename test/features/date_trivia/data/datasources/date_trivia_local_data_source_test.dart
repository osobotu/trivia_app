import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<InputConverter>(),
])
import 'date_trivia_local_data_source_test.mocks.dart';

void main() {
  late DateTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockInputConverter = MockInputConverter();
    dataSource = DateTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
      inputConverter: mockInputConverter,
    );
  });

  group(
    'getLastDateTrivia',
    () {
      final testDateTriviaModel =
          DateTriviaModel.fromJson(jsonDecode(fixture('date_cached.json')));

      test(
        'should return a DateTrivia from SharedPreferences when there is one in the cache',
        () async {
          when(mockSharedPreferences.getString(any))
              .thenReturn(fixture('date_cached.json'));

          final result = await dataSource.getLastDateTrivia();

          verify(mockSharedPreferences.getString(CACHED_DATE_TRIVIA));
          expect(result, equals(testDateTriviaModel));
        },
      );

      test(
        'should throw a CacheException when there is no value cached',
        () {
          when(mockSharedPreferences.getString(any));

          final call = dataSource.getLastDateTrivia;

          expect(() => call(), throwsA(isA<CacheException>()));
        },
      );
    },
  );

  group(
    'cacheDateTrivia',
    () {
      const testDateTriviaModel =
          DateTriviaModel(text: 'Test Text', number: 61, year: 1922);

      test(
        'should call SharedPreferences to cache the data',
        () {
          dataSource.cacheDateTrivia(testDateTriviaModel);

          final expectedJsonString = jsonEncode(testDateTriviaModel.toJson());

          verify(
            mockSharedPreferences.setString(
                CACHED_DATE_TRIVIA, expectedJsonString),
          );
        },
      );
    },
  );

  group(
    'addDateTriviaToFavorites',
    () {
      final testFavoriteDateTriviaModel = FavoriteDateTriviaModel(
        text: 'Test Text',
        number: 61,
        year: 1922,
        createdAt: DateTime(2022),
      );

      const testDateTriviaModel =
          DateTriviaModel(text: 'Test Text', number: 61, year: 1922);

      setUp(() {
        when(mockInputConverter.triviaToFavoriteDate(testDateTriviaModel))
            .thenReturn(Right(testFavoriteDateTriviaModel));
        when(mockSharedPreferences.getString(any)).thenReturn(jsonEncode([]));
      });

      test(
        'should call InputConverter.triviaToFavoriteDate on DateTrivia input',
        () {
          // when(mockSharedPreferences.getString(any)).thenReturn(jsonEncode([]));
          dataSource.addDateTriviaToFavorites(testDateTriviaModel);

          verify(mockInputConverter.triviaToFavoriteDate(testDateTriviaModel));
        },
      );

      test(
        'should call SharedPreference to add date trivia to favorites',
        () {
          dataSource.addDateTriviaToFavorites(testDateTriviaModel);

          verify(mockSharedPreferences.getString(FAVORITE_DATE_TRIVIA));

          verify(mockSharedPreferences.setString(
              FAVORITE_DATE_TRIVIA, jsonEncode([testFavoriteDateTriviaModel])));
        },
      );
    },
  );
}
