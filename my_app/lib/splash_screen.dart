import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    callDelay(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xff63b4ae), Color(0xff438883)]
            , // Set your gradient colors
          ),
        ),
        child:Center(
          child:  const Text("Сайн уу?",
            style: TextStyle(color: Colors.white,
                fontSize: 45),),
        )
      ),
    );
  }
  Future callDelay(BuildContext context) async  {
    await Future.delayed(const Duration( milliseconds: 5000), () {});
    Navigator.pushNamed(context, "/onboarding");
  }
}