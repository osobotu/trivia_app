import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group(
    'stringToUnsignedInteger',
    () {
      test(
        'should return an integer when the string represents an unsigned integer.',
        () {
          const str = '123';

          final result = inputConverter.stringToUnsignedInteger(str);

          expect(result, const Right(123));
        },
      );

      test(
        'should return a failure when the string is not an integer',
        () {
          const str = 'abc';
          final result = inputConverter.stringToUnsignedInteger(str);

          expect(result, Left(InvalidInputFailure()));
        },
      );

      test(
        'should return a failure when the string is a negative integer',
        () {
          const str = '-123';
          final result = inputConverter.stringToUnsignedInteger(str);
          expect(result, Left(InvalidInputFailure()));
        },
      );
    },
  );

  group(
    'getMonthAndDayFromDateTime',
    () {
      test(
        'should return the correct DateParams from the given DateTime',
        () {
          final date = DateTime.now();

          final result = inputConverter.getMonthAndDayFromDateTime(date);

          expect(
            result,
            Right(DateParams(month: date.month, day: date.day)),
          );
        },
      );
    },
  );

  group("triviaToFavoriteNumber", () {
    test(
      'should return a FavoriteNumberTrivia with the correct data',
      () {
        const testNumberTrivia = NumberTrivia(text: "Test Text", number: 1);
        final now = DateTime.now();
        final expectedResult = FavoriteNumberTriviaModel(
          createdAt: DateTime(now.year, now.month, now.day),
          number: 1,
          text: "Test Text",
        );
        final result = inputConverter.triviaToFavoriteNumber(testNumberTrivia);
        expect(result, Right(expectedResult));
      },
    );
  });
  group("triviaToFavoriteDate", () {
    test(
      'should return a FavoriteDateTrivia with the correct data',
      () {
        const testDateTrivia =
            DateTrivia(text: 'Test Text', number: 61, year: 2023);
        final now = DateTime.now();
        final expectedResult = FavoriteDateTriviaModel(
          createdAt: DateTime(now.year, now.month, now.day),
          number: 61,
          text: 'Test Text',
          year: 2023,
        );
        final result = inputConverter.triviaToFavoriteDate(testDateTrivia);
        expect(result, Right(expectedResult));
      },
    );
  });
}
