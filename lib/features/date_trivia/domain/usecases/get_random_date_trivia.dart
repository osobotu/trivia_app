import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/domain/entities/entities.dart';
import 'package:number_trivia_app/features/date_trivia/domain/repositories/repositories.dart';

class GetRandomDateTrivia extends UseCase<DateTrivia, NoParams> {
  final DateTriviaRepository repository;

  GetRandomDateTrivia(this.repository);

  @override
  Future<Either<Failure, DateTrivia>> call(NoParams params) async {
    return await repository.getRandomDateTrivia();
  }
}
