import 'package:flutter/material.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

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
                  style: const TextStyle(fontSize: 40),
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
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
