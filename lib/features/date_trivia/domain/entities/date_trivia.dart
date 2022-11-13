import 'package:equatable/equatable.dart';

class DateTrivia extends Equatable {
  final String text;
  final int year;
  final int number;

  const DateTrivia({
    required this.text,
    required this.number,
    required this.year,
  });

  @override
  List<Object?> get props => [text];
}
