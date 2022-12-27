import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/domain/entities/entities.dart';
import 'package:number_trivia_app/features/date_trivia/domain/repositories/repositories.dart';

class GetDateTrivia extends UseCase<DateTrivia, DateParams> {
  final DateTriviaRepository repository;

  GetDateTrivia(this.repository);
  @override
  Future<Either<Failure, DateTrivia>> call(DateParams params) async {
    return await repository.getDateTrivia(month: params.month, day: params.day);
  }
}

class DateParams extends Equatable {
  final int month;
  final int day;

  DateParams({required this.month, required this.day});

  @override
  List<Object?> get props => [month, day];
}
