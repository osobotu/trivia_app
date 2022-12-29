import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  return Placeholder();
                }
              },
            ),
            NumberTriviaControls(),
          ],
        ),
      ),
    );
  }
}

class NumberTriviaControls extends StatefulWidget {
  const NumberTriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  State<NumberTriviaControls> createState() => _NumberTriviaControlsState();
}

class _NumberTriviaControlsState extends State<NumberTriviaControls> {
  String inputString = '';
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (value) {
            inputString = value;
          },
          onSubmitted: (value) {
            context
                .read<NumberTriviaBloc>()
                .add(GetTriviaForConcreteNumber(inputString));
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade700,
                  foregroundColor: Colors.white,
                ),
                child: Text('Search'),
                onPressed: () {
                  controller.clear();
                  context
                      .read<NumberTriviaBloc>()
                      .add(GetTriviaForConcreteNumber(inputString));
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                child: Text('Get Random Trivia'),
                onPressed: () {
                  controller.clear();
                  context
                      .read<NumberTriviaBloc>()
                      .add(GetTriviaForRandomNumber());
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class NumberTriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;
  const NumberTriviaDisplay({
    Key? key,
    required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trivia.number.toString().length < 8
                      ? trivia.number.toString()
                      : trivia.number.toStringAsExponential(1),
                  style: const TextStyle(fontSize: 50),
                ),
                IconButton(
                    iconSize: 50,
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_outline)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              trivia.text,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  const MessageDisplayWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
