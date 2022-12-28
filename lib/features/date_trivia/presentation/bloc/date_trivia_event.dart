part of 'date_trivia_bloc.dart';

abstract class DateTriviaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTriviaForConcreteDate extends DateTriviaEvent {
  final DateTime date;

  GetTriviaForConcreteDate(this.date);
  @override
  List<Object?> get props => [date];
}

class GetTriviaForRandomDate extends DateTriviaEvent {}
