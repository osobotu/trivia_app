import 'package:number_trivia_app/features/date_trivia/domain/entities/entities.dart';

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
}
