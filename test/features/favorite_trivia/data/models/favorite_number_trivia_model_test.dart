import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

void main() {
  final testFavoriteNumberTriviaModel = FavoriteNumberTriviaModel(
    id: 'id',
    createdAt: DateTime(2023),
    number: 1,
    text: 'Test Text',
  );

  group(
    'FavoriteNumberTriviaModel',
    () {
      test(
        'should be a subclass of [FavoriteNumberTrivia] entity',
        () {
          expect(
            testFavoriteNumberTriviaModel,
            isA<FavoriteNumberTrivia>(),
          );
        },
      );

      group('toJson', () {
        test(
          'should return a Map object containing the correct data',
          () {
            final result = testFavoriteNumberTriviaModel.toJson();

            final expectedMap = {
              "text": "Test Text",
              "createdAt": DateTime(2023).toIso8601String(),
              "id": "id",
              "number": 1,
            };

            expect(result, expectedMap);
          },
        );
      });

      group(
        'fromJson',
        () {
          test(
            'should return a [FavoriteNumberTriviaModel] from a json object',
            () {
              final jsonMap = {
                "text": "Test Text",
                "createdAt": DateTime(2023).toIso8601String(),
                "id": "id",
                "number": 1,
              };
              final jsonString = jsonEncode(jsonMap);

              final result =
                  FavoriteNumberTriviaModel.fromJson(jsonDecode(jsonString));

              expect(result, testFavoriteNumberTriviaModel);
            },
          );
        },
      );
    },
  );
}
