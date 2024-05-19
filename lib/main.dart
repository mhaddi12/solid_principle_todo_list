import 'package:flutter/material.dart';
import 'package:solid_principle_todo_list/splash_sreen.dart';
import 'package:solid_principle_todo_list/views/home_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
