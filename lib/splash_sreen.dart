import 'package:flutter/material.dart';
import 'package:solid_principle_todo_list/views/home_view.dart';
import 'package:lottie/lottie.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LinearProgressIndicator(
            //     backgroundColor: Colors.purpleAccent,
            //     minHeight: 10.0,
            //     semanticsLabel: "LOADING",
            //     semanticsValue: "LOADING"),


            Image.network(
              "https://th.bing.com/th/id/R.e744940be065f3c03cf255a61951f2c0?rik=G%2fLiBWR8jeRnbA&pid=ImgRaw&r=0",
              width: MediaQuery.of(context).size.width * 0.5,
            ) ,//Text("Loading...")
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
            ),
            Lottie.asset("assets/images/loading.json",
                width: MediaQuery.of(context).size.width * 0.3),
          ],
        ),
      ),
    );
  }
}
