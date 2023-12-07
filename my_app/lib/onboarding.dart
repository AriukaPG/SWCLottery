import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 450.0,
              width: 415.0,
              decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(350, 50)), 
                color: Color(0xffF58742),
              ), 
              child: Image.asset('assets/images/login.png'),
            )
          ],),
          const SizedBox(height: 50),
          const Text(
            'ИЛҮҮ ХУРДАН\nИЛҮҮ ХЭМНЭЛТТЭЙ',
            textAlign:  TextAlign.center,
            style: TextStyle(color:  Color(0xff464444),
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const Text(
            'Сугалааны ертөнцэд тавтай морил!',
            textAlign:  TextAlign.center,
            style: TextStyle(color:  Color(0xff464444), fontSize: 18),
          ),
          const SizedBox(height: 100),
          Row(
            children: [
              const SizedBox(width: 30), 
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context,"/login");
                  }, 
                child: Container(
                  width: 180, 
                  height: 50, 
                  decoration: BoxDecoration(
                    color: const Color(0xffF58742), 
                    borderRadius: BorderRadius.circular(0),
                ),
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ), 
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context,"/register");
                  },
                child: Container(
                  width: 180, 
                  height: 50, 
                  decoration: BoxDecoration(
                    color: const Color(0xffD2D2D2), 
                    borderRadius: BorderRadius.circular(0),
                  ), 
                  child: const Center(
                    child: Text(
                      'Register', 
                      style: TextStyle(
                        color: Color(0xff545151), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
