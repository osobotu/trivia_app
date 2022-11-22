import 'dart:convert';

import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:http/http.dart' as http;

abstract class DateTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{month}/{day}/date endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel> getDateTrivia({required int month, required int day});

  /// Calls the http://numbersapi.com/random/date endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DateTriviaModel> getRandomDateTrivia();
}

class DateTriviaRemoteDataSourceImpl implements DateTriviaRemoteDataSource {
  final http.Client client;

  DateTriviaRemoteDataSourceImpl({required this.client});
  @override
  Future<DateTriviaModel> getDateTrivia(
          {required int month, required int day}) =>
      _getDateTriviaFromUrl(APIConstants.dateEndpoint(month, day));

  @override
  Future<DateTriviaModel> getRandomDateTrivia() {
    // TODO: implement getRandomDateTrivia
    throw UnimplementedError();
  }

  Future<DateTriviaModel> _getDateTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: APIConstants.headers,
    );
    if (response.statusCode == 200) {
      return DateTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
