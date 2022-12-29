import 'package:flutter/material.dart';
import 'package:number_trivia_app/features/app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
