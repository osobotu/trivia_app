import 'package:number_trivia_app/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteDateTriviaRepositoryImpl implements FavoriteDateTriviaRepository {
  final FavoriteDateTriviaLocalDataSource localDataSource;

  FavoriteDateTriviaRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<FavoriteDateTrivia>>>
      getFavoriteDateTrivia() async {
    try {
      final result = await localDataSource.getFavoriteDateTrivia();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteDateTrivia>> removeFavoriteDateTrivia(
      String id) async {
    try {
      final result = await localDataSource.removeFavoriteDateTrivia(id);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
