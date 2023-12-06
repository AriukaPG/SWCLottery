import 'package:flutter/material.dart';
import 'package:my_app/login_screen.dart';
import 'package:my_app/register_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
        ],),),);
  }
}