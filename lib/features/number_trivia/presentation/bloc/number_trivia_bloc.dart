import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _concrete;
  final GetRandomNumberTrivia _random;
  final InputConverter _inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required InputConverter inputConverter,
  })  : _concrete = concrete,
        _random = random,
        _inputConverter = inputConverter,
        super(Empty()) {
    // on<NumberTriviaEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
  }

  Future<void> _onGetTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither =
        _inputConverter.stringToUnsignedInteger(event.numberString);

    inputEither.fold(
      (failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (r) => throw UnimplementedError(),
    );
  }
}
