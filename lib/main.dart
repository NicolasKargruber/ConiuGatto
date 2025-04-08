import 'package:coniugatto/screens/home_screen.dart';
import 'package:coniugatto/view_models/verb_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: ChangeNotifierProvider(
        create: (_) => VerbViewModel(),
        child: HomeScreen(),
      ),
    );
  }
}
