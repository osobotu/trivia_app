import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

abstract class FavoriteDateTriviaRepository {
  Future<Either<Failure, List<FavoriteDateTrivia>>> getFavoriteDateTrivia();

  Future<Either<Failure, FavoriteDateTrivia>> removeFavoriteDateTrivia(
      String id);
}
