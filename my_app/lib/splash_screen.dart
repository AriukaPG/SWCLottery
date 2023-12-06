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
            colors: <Color>[Color(0xffF58742), Color(0xffFFD000)]
            , // Set your gradient colors
          ),
          //color: Color(0xffF58742)
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