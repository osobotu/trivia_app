import 'package:number_trivia_app/features/date_trivia/domain/entities/entities.dart';
import 'package:number_trivia_app/features/favorite_trivia/data/models/models.dart';
import 'package:uuid/uuid.dart';

class DateTriviaModel extends DateTrivia {
  const DateTriviaModel(
      {required super.text, required super.number, required super.year});

  factory DateTriviaModel.fromJson(Map<String, dynamic> json) {
    return DateTriviaModel(
      text: json['text'],
      number: json['number'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
      'year': year,
    };
  }

  FavoriteDateTriviaModel toFavorite() {
    return FavoriteDateTriviaModel(
      createdAt: DateTime.now(),
      number: number,
      text: text,
      year: year,
      id: const Uuid().v4(),
    );
  }
}
