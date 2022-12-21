import 'package:equatable/equatable.dart';

class FavoriteDateTrivia extends Equatable {
  final String text;
  final DateTime createdAt;
  final int number;
  final int year;
  final String id;

  const FavoriteDateTrivia({
    required this.createdAt,
    required this.number,
    required this.text,
    required this.year,
    required this.id,
  });

  @override
  List<Object?> get props => [id, text, number, createdAt, year];
}
