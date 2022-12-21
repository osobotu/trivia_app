import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

void main() {
  final testFavoriteDateTriviaModel = FavoriteDateTriviaModel(
    id: 'id',
    text: 'Test Text',
    number: 61,
    year: 1922,
    createdAt: DateTime(2022),
  );

  test(
    'should be a subclass of [FavoriteDateTrivia] entity',
    () {
      expect(
        testFavoriteDateTriviaModel,
        isA<FavoriteDateTrivia>(),
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a Map object containing the correct data',
        () {
          final result = testFavoriteDateTriviaModel.toJson();

          final expectedMap = {
            "text": 'Test Text',
            "number": 61,
            "year": 1922,
            "id": 'id',
            "createdAt": DateTime(2022).toIso8601String(),
          };

          expect(result, expectedMap);
        },
      );
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid [FavoriteDateTriviaModel] from a json string',
        () {
          final jsonString = jsonEncode(testFavoriteDateTriviaModel.toJson());
          final result =
              FavoriteDateTriviaModel.fromJson(jsonDecode(jsonString));

          expect(result, testFavoriteDateTriviaModel);
        },
      );
    },
  );
}
