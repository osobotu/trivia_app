import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

abstract class DateTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{month}/{day}/date endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel> getDateTrivia({required int month, required int day});

  /// Calls the http://numbersapi.com/random/date endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel> getRandomDateTrivia();
}
