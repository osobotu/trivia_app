part of 'date_trivia_bloc.dart';

abstract class DateTriviaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTriviaForDate extends DateTriviaEvent {
  final String date;

  GetTriviaForDate(this.date);
  @override
  List<Object?> get props => [date];
}

class GetTriviaForRandomDate extends DateTriviaEvent {}
