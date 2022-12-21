import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteDateTriviaModel extends FavoriteDateTrivia {
  const FavoriteDateTriviaModel({
    required super.createdAt,
    required super.number,
    required super.text,
    required super.year,
    required super.id,
  });

  factory FavoriteDateTriviaModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDateTriviaModel(
      createdAt: DateTime.parse(json['createdAt']),
      number: json['number'],
      text: json['text'],
      year: json['year'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "number": number,
      "year": year,
      "id": id,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
