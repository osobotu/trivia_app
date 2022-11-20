import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_trivia_event.dart';
part 'favorite_trivia_state.dart';

class FavoriteTriviaBloc extends Bloc<FavoriteTriviaEvent, FavoriteTriviaState> {
  FavoriteTriviaBloc() : super(FavoriteTriviaInitial()) {
    on<FavoriteTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
