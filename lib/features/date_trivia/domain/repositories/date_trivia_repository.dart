import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

abstract class DateTriviaRepository {
  Future<Either<Failure, DateTrivia>> getDateTrivia(
      {required int month, required int day});

  Future<Either<Failure, DateTrivia>> getRandomDateTrivia();
}
