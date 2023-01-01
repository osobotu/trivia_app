import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/favorite_trivia/favorite_trivia.dart';

class RemoveFavoriteDateTrivia extends UseCase<FavoriteDateTrivia, Params> {
  final FavoriteDateTriviaRepository repository;

  RemoveFavoriteDateTrivia(this.repository);

  @override
  Future<Either<Failure, FavoriteDateTrivia>> call(Params params) async {
    return await repository.removeFavoriteDateTrivia(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
