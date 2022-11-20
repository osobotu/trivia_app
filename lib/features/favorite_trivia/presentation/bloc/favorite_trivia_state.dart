part of 'favorite_trivia_bloc.dart';

abstract class FavoriteTriviaState extends Equatable {
  const FavoriteTriviaState();
  
  @override
  List<Object> get props => [];
}

class FavoriteTriviaInitial extends FavoriteTriviaState {}
