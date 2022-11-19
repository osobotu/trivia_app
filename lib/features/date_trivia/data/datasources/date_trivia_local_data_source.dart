import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

abstract class DateTriviaLocalDataSource {
  /// Gets the cached [DateTriviaModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present.
  ///
  Future<DateTriviaModel> getLastDateTrivia();

  Future<void> cacheDateTrivia(DateTriviaModel triviaToCache);
}
