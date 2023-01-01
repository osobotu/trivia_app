import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

abstract class FavoriteNumberTriviaRepository {
  Future<Either<Failure, List<FavoriteNumberTrivia>>> getFavoriteNumberTrivia();

  Future<Either<Failure, FavoriteNumberTrivia>> removeFavoriteNumberTrivia(
      String id);
}
