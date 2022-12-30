import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

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
                child: const Text('Search'),
                onPressed: () {
                  controller.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                  context
                      .read<NumberTriviaBloc>()
                      .add(GetTriviaForConcreteNumber(inputString));
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                child: const Text('Get Random Trivia'),
                onPressed: () {
                  controller.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
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
