import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testDateTriviaModel =
      DateTriviaModel(text: 'Test Text', number: 61, year: 1922);
  test(
    'should be a subclass of DateTrivia entity',
    () {
      expect(testDateTriviaModel, isA<DateTrivia>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid DateTriviaModel from Json object',
        () {
          final jsonMap = jsonDecode(fixture('date_trivia.json'));
          final result = DateTriviaModel.fromJson(jsonMap);

          expect(result, testDateTriviaModel);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a Map object containing the correct data',
        () {
          final result = testDateTriviaModel.toJson();

          final expectedJsonMap = {
            "text": "Test Text",
            "number": 61,
            "year": 1922,
          };

          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
