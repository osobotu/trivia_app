import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/domain/domain.dart';

class GetFavoriteNumberTrivia
    extends UseCase<List<FavoriteNumberTrivia>, NoParams> {
  final FavoriteNumberTriviaRepository repository;

  GetFavoriteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, List<FavoriteNumberTrivia>>> call(
      NoParams params) async {
    return await repository.getFavoriteNumberTrivia();
  }
}
