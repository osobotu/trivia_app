import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class RemoveFavoriteNumberTrivia extends UseCase<FavoriteNumberTrivia, Params> {
  final FavoriteNumberTriviaRepository repository;

  RemoveFavoriteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, FavoriteNumberTrivia>> call(Params params) async {
    return await repository.removeFavoriteNumberTrivia(params.id);
  }
}
