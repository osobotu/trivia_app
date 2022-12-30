import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/injection_container.dart';

class DateTriviaPage extends StatelessWidget {
  const DateTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DateTriviaBloc>(),
      child: const DateTriviaView(),
    );
  }
}

class DateTriviaView extends StatelessWidget {
  const DateTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            BlocBuilder<DateTriviaBloc, DateTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return const MessageDisplayWidget(
                    message: 'Enter a date or \nGet a random date fact.',
                  );
                } else if (state is Loading) {
                  return const LoadingWidget();
                } else if (state is Error) {
                  return MessageDisplayWidget(message: state.message);
                } else if (state is Loaded) {
                  return DateTriviaDisplayWidget(
                    trivia: state.trivia,
                  );
                }
                return const MessageDisplayWidget(
                  message:
                      'What could you have done to get here? Break the app, yeah? 😾',
                );
              },
            ),
            const DateTriviaControls(),
          ],
        ),
      ),
    );
  }
}
