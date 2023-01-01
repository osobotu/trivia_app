import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

abstract class FavoriteNumberTriviaLocalDataSource {
  Future<List<FavoriteNumberTriviaModel>> getFavoriteNumberTrivia();
}
