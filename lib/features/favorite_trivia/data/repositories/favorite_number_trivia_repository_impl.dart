import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteNumberTriviaRepositoryImpl
    implements FavoriteNumberTriviaRepository {
  final FavoriteNumberTriviaLocalDataSource localDataSource;

  FavoriteNumberTriviaRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<FavoriteNumberTrivia>>>
      getFavoriteNumberTrivia() async {
    try {
      final result = await localDataSource.getFavoriteNumberTrivia();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteNumberTrivia>> removeFavoriteNumberTrivia(
      String id) async {
    try {
      final result = await localDataSource.removeFavoriteNumberTrivia(id);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
