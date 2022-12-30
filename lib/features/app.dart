import 'package:flutter/material.dart';
import 'package:number_trivia_app/features/date_trivia/date_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/number_trivia.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia App'),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          NumberTriviaPage(),
          Center(
            child: Text('Favorites'),
          ),
          DateTriviaPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Number',
            icon: Icon(Icons.numbers_outlined),
            tooltip: 'Number Trivia',
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite_outline),
            tooltip: 'Favorite Trivia',
          ),
          BottomNavigationBarItem(
            label: 'Date',
            icon: Icon(Icons.calendar_month_outlined),
            tooltip: 'Date Trivia',
          ),
        ],
      ),
    );
  }
}
