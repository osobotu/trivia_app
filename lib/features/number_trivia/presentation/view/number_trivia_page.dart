import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/core.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';
import 'package:number_trivia_app/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: const NumberTriviaView(),
    );
  }
}

class NumberTriviaView extends StatelessWidget {
  const NumberTriviaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return const MessageDisplayWidget(
                    message: 'Start Searching',
                  );
                } else if (state is Loading) {
                  return const LoadingWidget();
                } else if (state is Error) {
                  return MessageDisplayWidget(message: state.message);
                } else if (state is Loaded) {
                  return NumberTriviaDisplay(trivia: state.trivia);
                } else {
                  return const MessageDisplayWidget(
                      message: 'If you get here, you crashed the app. LOL! 😹');
                }
              },
            ),
            const NumberTriviaControls(),
          ],
        ),
      ),
    );
  }
}
