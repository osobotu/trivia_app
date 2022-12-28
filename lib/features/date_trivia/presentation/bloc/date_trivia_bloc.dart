import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/core.dart';

import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

part 'date_trivia_event.dart';
part 'date_trivia_state.dart';

class DateTriviaBloc extends Bloc<DateTriviaEvent, DateTriviaState> {
  final GetConcreteDateTrivia _concrete;
  final GetRandomDateTrivia _random;
  final InputConverter _inputConverter;

  DateTriviaBloc({
    required GetConcreteDateTrivia concrete,
    required GetRandomDateTrivia random,
    required InputConverter inputConverter,
  })  : _concrete = concrete,
        _random = random,
        _inputConverter = inputConverter,
        super(Empty()) {
    on<GetTriviaForConcreteDate>(_onGetTriviaForConcreteDate);
  }

  Future<void> _onGetTriviaForConcreteDate(
    GetTriviaForConcreteDate event,
    Emitter<DateTriviaState> emit,
  ) async {
    final inputEither = _inputConverter.getMonthAndDayFromDateTime(event.date);

    inputEither.fold(
      (failure) => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (dateTrivia) => throw UnimplementedError(),
    );
  }
}
