import 'package:number_trivia_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteNumberTriviaRepositoryImpl
    implements FavoriteNumberTriviaRepository {
  @override
  Future<Either<Failure, List<FavoriteNumberTrivia>>>
      getFavoriteNumberTrivia() {
    // TODO: implement getFavoriteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FavoriteNumberTrivia>> removeFavoriteNumberTrivia(
      String id) {
    // TODO: implement removeFavoriteNumberTrivia
    throw UnimplementedError();
  }
}
