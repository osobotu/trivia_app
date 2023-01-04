import 'package:equatable/equatable.dart';

class FavoriteNumberTrivia extends Equatable {
  final String text;
  final DateTime createdAt;
  final int number;

  const FavoriteNumberTrivia({
    required this.createdAt,
    required this.number,
    required this.text,
  });

  @override
  List<Object?> get props => [text, createdAt, number];
}
