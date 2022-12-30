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
    on<GetTriviaForRandomDate>(_onGetTriviaForRandomDate);
  }

  Future<void> _onGetTriviaForConcreteDate(
    GetTriviaForConcreteDate event,
    Emitter<DateTriviaState> emit,
  ) async {
    final inputEither = _inputConverter.getMonthAndDayFromDateTime(event.date);

    await inputEither.fold(
      (failure) async => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (dateParams) async {
        emit(Loading());
        final failureOrTrivia = await _concrete(dateParams);
        _emitLoadedOrErrorState(emit, failureOrTrivia);
      },
    );
  }

  Future<void> _onGetTriviaForRandomDate(
    GetTriviaForRandomDate event,
    Emitter<DateTriviaState> emit,
  ) async {
    emit(Loading());
    final failureOrTrivia = await _random(NoParams());
    _emitLoadedOrErrorState(emit, failureOrTrivia);
  }

  void _emitLoadedOrErrorState(
    Emitter<DateTriviaState> emit,
    Either<Failure, DateTrivia> failureOrTrivia,
  ) {
    failureOrTrivia.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (trivia) => emit(Loaded(trivia: trivia)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
