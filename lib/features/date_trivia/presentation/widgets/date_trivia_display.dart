import 'package:flutter/material.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

class DateTriviaDisplayWidget extends StatelessWidget {
  final DateTrivia trivia;
  const DateTriviaDisplayWidget({
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
                  _getDateFromNumber(trivia.number),
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

  String _getDateFromNumber(int number) {
    Map<String, int> months = {
      'January': 31,
      'February': 29,
      'March': 31,
      'April': 30,
      'May': 31,
      'June': 30,
      'July': 31,
      'August': 31,
      'September': 30,
      'October': 31,
      'November': 30,
      'December': 31,
    };

    int index = 0;
    var monthsKeys = months.keys.toList();
    do {
      var month = monthsKeys[index];

      if (months[month]! >= number) {
        return '$month $number';
      }
      number -= months[month]!;
      index = (index + 1) % monthsKeys.length;
    } while (number > 0);
    return '';
  }
}
