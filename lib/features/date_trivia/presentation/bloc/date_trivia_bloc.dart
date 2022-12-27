import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

part 'date_trivia_event.dart';
part 'date_trivia_state.dart';

class DateTriviaBloc extends Bloc<DateTriviaEvent, DateTriviaState> {
  DateTriviaBloc() : super(Empty()) {
    on<DateTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
