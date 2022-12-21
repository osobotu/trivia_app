import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'date_trivia_local_data_source_test.mocks.dart';

void main() {
  late DateTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = DateTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
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
        id: 'id',
        text: 'Test Text',
        number: 61,
        year: 1922,
        createdAt: DateTime(2022),
      );

      test(
        'should call SharedPreferences to cache the data',
        () {
          dataSource.addDateTriviaToFavorites(testFavoriteDateTriviaModel);

          String favoriteDateTriviaString =
              mockSharedPreferences.getString(FAVORITE_DATE_TRIVIA).toString();
          final favoriteDateTrivia = List<Map<dynamic, dynamic>>.from(
                  jsonDecode(favoriteDateTriviaString))
              .map(
                (jsonMap) => FavoriteDateTriviaModel.fromJson(
                  Map<String, dynamic>.from(jsonMap),
                ),
              )
              .toList();

          expect(testFavoriteDateTriviaModel, favoriteDateTrivia.last);
        },
      );
    },
  );
}
