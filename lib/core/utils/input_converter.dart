import 'package:dartz/dartz.dart';

import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, DateParams> getMonthAndDayFromDateTime(DateTime date) {
    try {
      return Right(DateParams(month: date.month, day: date.day));
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
