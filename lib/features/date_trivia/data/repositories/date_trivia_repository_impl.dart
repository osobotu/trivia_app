import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:dartz/dartz.dart';

typedef _ConcreteOrRandom = Future<DateTriviaModel> Function();

class DateTriviaRepositoryImpl implements DateTriviaRepository {
  final DateTriviaRemoteDataSource remoteDataSource;
  final DateTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DateTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, DateTrivia>> getDateTrivia(
      {required int month, required int day}) async {
    return await _getDateTrivia(
        () => remoteDataSource.getDateTrivia(month: month, day: day));
  }

  @override
  Future<Either<Failure, DateTrivia>> getRandomDateTrivia() async {
    return await _getDateTrivia(() => remoteDataSource.getRandomDateTrivia());
  }

  @override
  Future<void> addDateTriviaToFavorites(DateTrivia dateTrivia) {
    // TODO: implement addDateTriviaToFavorites
    throw UnimplementedError();
  }

  Future<Either<Failure, DateTrivia>> _getDateTrivia(
      _ConcreteOrRandom getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDateTrivia = await getConcreteOrRandom();
        localDataSource.cacheDateTrivia(remoteDateTrivia);
        return Right(remoteDateTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDateTrivia = await localDataSource.getLastDateTrivia();
        return Right(localDateTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
