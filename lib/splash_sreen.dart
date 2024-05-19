import 'package:flutter/material.dart';
import 'package:solid_principle_todo_list/views/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
                backgroundColor: Colors.purpleAccent,
                minHeight: 10.0,
                semanticsLabel: "LOADING",
                semanticsValue: "LOADING"),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}
