import 'package:equatable/equatable.dart';

class FavoriteDateTrivia extends Equatable {
  final String text;
  final DateTime createdAt;
  final int number;
  final int year;

  const FavoriteDateTrivia({
    required this.createdAt,
    required this.number,
    required this.text,
    required this.year,
  });

  @override
  List<Object?> get props => [text, number, createdAt, year];
}
