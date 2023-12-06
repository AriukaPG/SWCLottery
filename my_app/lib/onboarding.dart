import 'package:flutter/material.dart';
import 'package:my_app/login_screen.dart';

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
          SizedBox(height: 50),
          Text(
            'ИЛҮҮ ХУРДАН\nИЛҮҮ ХЭМНЭЛТТЭЙ',
            textAlign:  TextAlign.center,
            style: TextStyle(color:  Color(0xff464444),
                fontSize: 24, fontWeight: FontWeight.bold)
            ,
          ),
          SizedBox(height: 30),
          Text(
            'Сугалааны ертөнцэд тавтай морил!',
            textAlign:  TextAlign.center,
            style: TextStyle(color:  Color(0xff464444),
                fontSize: 18)
            ,
          ),
          SizedBox(height: 100),
          Row(
    children: [
      SizedBox(width: 30),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,"/login");
                //MaterialPageRoute(builder: (context) => RegisterScreen()),
                //);
              },
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffF58742),
                  borderRadius: BorderRadius.circular(0),

                ),
                child: Center(
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
          Navigator.pushNamed(
              context,"/register");
          //MaterialPageRoute(builder: (context) => RegisterScreen()),
          //);
        },
        child: Container(
          width: 180,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xffD2D2D2),
            borderRadius: BorderRadius.circular(0),

          ),
          child: Center(
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
          ],)
        ],
      ),

      /*Center(child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Image.asset('assets/images/people.png',height: 400,width: 524,),
        SizedBox(height: 30),
        Text(
          'УХААЛАГ ЗАРЦУУЛЖ \nИЛҮҮ ХЭМНЭЕ',
          textAlign:  TextAlign.center,
          style: TextStyle(color:  Color(0xff438883),
              fontSize: 24, fontWeight: FontWeight.bold)
            ,
          ),
        SizedBox(height: 45),
        InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,"/register");
            //MaterialPageRoute(builder: (context) => RegisterScreen()),
          //);
        },
        child: Container(
        width: 260,
        height: 50,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors:  <Color>[Color(0xff63b4ae), Color(0xff438883)],
        ),
        borderRadius: BorderRadius.circular(30),

        ),
          child: Center(
            child: Text(
              'Эхлэх',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

        ),
        ),
        ),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Хэрэглэгчийн Эрх бий юу?'
            ,
            style: TextStyle(backgroundColor: Colors.white),),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                LoginScreen()/*context, "/login"*/),);
          },
          child: new Text("Нэвтрэх", style: TextStyle(color: Color(0xff32819a))),
        ),

          ],
        ),
        SizedBox(height: 30),
        ],*/);
  }
}