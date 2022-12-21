import 'dart:convert';

import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class DateTriviaLocalDataSource {
  /// Gets the cached [DateTriviaModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present.
  ///
  Future<DateTriviaModel> getLastDateTrivia();

  Future<void> cacheDateTrivia(DateTriviaModel triviaToCache);

  Future<void> addDateTriviaToFavorites(
      FavoriteDateTriviaModel favoriteDateTrivia);
}

class DateTriviaLocalDataSourceImpl implements DateTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  DateTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheDateTrivia(DateTriviaModel triviaToCache) {
    final jsonString = jsonEncode(triviaToCache.toJson());
    return sharedPreferences.setString(CACHED_DATE_TRIVIA, jsonString);
  }

  @override
  Future<DateTriviaModel> getLastDateTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_DATE_TRIVIA);
    if (jsonString != null) {
      return Future.value(DateTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> addDateTriviaToFavorites(
      FavoriteDateTriviaModel favoriteDateTrivia) {
    final favoriteDateTriviaString =
        sharedPreferences.getString(FAVORITE_DATE_TRIVIA);
    if (favoriteDateTriviaString != null) {
      final favoriteDateTriviaList =
          List<Map<dynamic, dynamic>>.from(jsonDecode(favoriteDateTriviaString))
              .map(
                (jsonMap) => FavoriteDateTriviaModel.fromJson(
                  Map<String, dynamic>.from(jsonMap),
                ),
              )
              .toList();
      favoriteDateTriviaList.add(favoriteDateTrivia);
      return sharedPreferences.setString(
          FAVORITE_DATE_TRIVIA, jsonEncode(favoriteDateTriviaList));
    } else {
      throw CacheException();
    }
  }
}
