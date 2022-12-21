import 'package:equatable/equatable.dart';

class FavoriteNumberTrivia extends Equatable {
  final String text;
  final DateTime createdAt;
  final int number;
  final String id;

  const FavoriteNumberTrivia({
    required this.createdAt,
    required this.number,
    required this.text,
    required this.id,
  });

  @override
  List<Object?> get props => [id, text, createdAt, number];
}
