import 'package:number_trivia_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteDateTriviaRepositoryImpl implements FavoriteDateTriviaRepository {
  @override
  Future<Either<Failure, List<FavoriteDateTrivia>>> getFavoriteDateTrivia() {
    // TODO: implement getFavoriteDateTrivia
    throw UnimplementedError();
  }
}
