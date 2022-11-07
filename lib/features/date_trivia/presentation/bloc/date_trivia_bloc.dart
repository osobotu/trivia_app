import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_trivia_event.dart';
part 'date_trivia_state.dart';

class DateTriviaBloc extends Bloc<DateTriviaEvent, DateTriviaState> {
  DateTriviaBloc() : super(DateTriviaInitial()) {
    on<DateTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
