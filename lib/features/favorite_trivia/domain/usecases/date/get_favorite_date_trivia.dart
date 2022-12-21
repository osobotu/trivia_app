import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class GetFavoriteDateTrivia
    extends UseCase<List<FavoriteDateTrivia>, NoParams> {
  final FavoriteDateTriviaRepository repository;

  GetFavoriteDateTrivia(this.repository);
  @override
  Future<Either<Failure, List<FavoriteDateTrivia>>> call(
      NoParams params) async {
    return await repository.getFavoriteDateTrivia();
  }
}
