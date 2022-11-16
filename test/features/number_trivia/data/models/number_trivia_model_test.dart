import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('should be a subclass of NumberTrivia entity', () async {
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON number is an integer',
        () {
          final Map<String, dynamic> jsonMap =
              jsonDecode(fixture('trivia.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);

          expect(result, testNumberTriviaModel);
        },
      );

      test(
          'should return a valid model when the JSON number is regarded as a double',
          () {
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('trivia_double.json'));

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, testNumberTriviaModel);
      });
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () {
          final result = testNumberTriviaModel.toJson();

          final expectedJsonMap = {
            "text": "Test Text",
            "number": 1,
          };

          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
