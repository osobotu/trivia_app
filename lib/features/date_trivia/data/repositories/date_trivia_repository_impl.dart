import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:dartz/dartz.dart';

class DateTriviaRepositoryImpl implements DateTriviaRepository {
  final DateTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DateTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, DateTrivia>> getDateTrivia(
      {required int month, required int day}) {
    // TODO: implement getDateTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DateTrivia>> getRandomDateTrivia() {
    // TODO: implement getRandomDateTrivia
    throw UnimplementedError();
  }
}
