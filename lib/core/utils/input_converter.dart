import 'package:dartz/dartz.dart';

import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';
import 'package:uuid/uuid.dart';

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

  Either<Failure, FavoriteDateTrivia> triviaToFavoriteDate(
      DateTrivia dateTrivia) {
    try {
      final now = DateTime.now();
      final favoriteDateTrivia = FavoriteDateTriviaModel(
        createdAt: DateTime(now.year, now.month, now.day),
        number: dateTrivia.number,
        text: dateTrivia.text,
        year: dateTrivia.year,
      );
      return Right(favoriteDateTrivia);
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, FavoriteNumberTrivia> triviaToFavoriteNumber(
      NumberTrivia numberTrivia) {
    final now = DateTime.now();
    try {
      final favoriteNumberTrivia = FavoriteNumberTriviaModel(
        createdAt: DateTime(now.year, now.month, now.day),
        number: numberTrivia.number,
        text: numberTrivia.text,
      );
      return Right(favoriteNumberTrivia);
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
