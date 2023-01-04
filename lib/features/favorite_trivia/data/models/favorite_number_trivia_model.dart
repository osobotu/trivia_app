import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class FavoriteNumberTriviaModel extends FavoriteNumberTrivia {
  const FavoriteNumberTriviaModel({
    required super.createdAt,
    required super.number,
    required super.text,
  });

  factory FavoriteNumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return FavoriteNumberTriviaModel(
      createdAt: DateTime.parse(json['createdAt']),
      number: json['number'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
      };
}
