import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';

class DateTriviaControls extends StatelessWidget {
  const DateTriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple.shade700,
              ),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                );
                if (selectedDate != null) {
                  context
                      .read<DateTriviaBloc>()
                      .add(GetTriviaForConcreteDate(selectedDate));
                }
              },
              child: const Text('Enter Date'),
            )),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<DateTriviaBloc>()
                        .add(GetTriviaForRandomDate());
                  },
                  child: const Text('Get Random Date Trivia')),
            ),
          ],
        ),
      ],
    );
  }
}
