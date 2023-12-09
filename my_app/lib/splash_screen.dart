import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    callDelay(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xffF58742), Color(0xffFFD000)],
            ),
          ),
          child: const Center(
            child:  Text("Сайн уу?",
              style: TextStyle(color: Colors.white,
                  fontSize: 45),),
          )
      ),
    );
  }

  Future callDelay(BuildContext context) async  {
    await Future.delayed(const Duration( milliseconds: 5000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, "/onboarding");
  }
}