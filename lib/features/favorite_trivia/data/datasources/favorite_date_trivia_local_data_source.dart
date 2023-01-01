import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

abstract class FavoriteDateTriviaLocalDataSource {
  Future<List<FavoriteDateTriviaModel>> getFavoriteDateTrivia();

  Future<FavoriteDateTriviaModel> removeFavoriteDateTrivia(String id);
}
