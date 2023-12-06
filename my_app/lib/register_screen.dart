import 'package:flutter/material.dart';
import 'package:my_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body:SingleChildScrollView(
    child:Column( children: [
        Stack(children: [
          Image.asset('assets/images/image2.png'),
          Positioned.fill(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Тавтай морилно уу?",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Сугалаа худалдаж авахад тань туслана",
                style: TextStyle(
                  color: Colors.white,

                  fontSize: 15,
                ),
              ),
            ],
          ),
          ),
        ],
        ),
        SizedBox(height: 50),
        Container(
          width: 310,
          height: 53,
          decoration: BoxDecoration(
               color: Colors.white,
              borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                border: InputBorder.none,
                hintText: 'Бүтэн нэрээ оруулна уу?'
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,

              ),
            ),

          ),

        ),
        SizedBox(height: 20),
        Container(
          width: 310,
          height: 53,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextField(
         controller: _emailController,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Имэйлээ оруулна уу?'
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,

              ),
            ),

          ),

        ),
        SizedBox(height: 20),
        Container(
          width: 310,
          height: 53,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Нууц үгээ оруулаарай'
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,

              ),
            ),

          ),

        ),
        SizedBox(height: 20),
        Container(
          width: 310,
          height: 53,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Нууц үгээ давтан оруулаарай'
              ),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,

              ),
            ),

          ),

        ),
        SizedBox(height: 40),
        InkWell(
          onTap: () async {
            // Access the text from controllers whenever needed

            if (_passwordController.text == _confirmPasswordController.text) {
              try {
                // Create user with email and password
                UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text,
                );

                // Update display name
                await userCredential.user!.updateDisplayName(
                  _nameController.text,
                );

                // Add user details to Firestore
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userCredential.user!.uid)
                    .set({
                  'uid': userCredential.user!.uid,
                  'displayName': _nameController.text,
                  'email': _emailController.text.trim(),
                });
                print("Created New Account");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Амжилттай бүртгэгдлээ.\nНэвтрэх дээр дарж нэвтэрнэ үү."),
                    duration: Duration(seconds: 3),
                  ),
                );
              } catch (error) {
                print("Error: $error");
              }
            } else {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Нууц үг таарахгүй байна."),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
      child:

    Container(
          width: 310,
          height: 53,
          decoration: BoxDecoration(
            color: Color(0xffF58742),
            borderRadius: BorderRadius.circular(30),

          ),
          child: Center(
            child: Text(
              'Бүртгүүлэх',
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
              ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      LoginScreen()/*context, "/login"*/),);
              },
              child: new Text("Нэвтрэх", style: TextStyle(color: Color(0xffF58742))),
            ),

          ],
        ),
        /*
        TextField(
          decoration: InputDecoration(
          labelText: 'Enter text',
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
    ),
        filled: true,
        fillColor: Colors.grey[200],
    ),
              ),*/
        ],),
    ),
    );


        /*ClipOval(
          child: Container(
            width: 150,
            height: 150,
            color:  Color(0xffACF0FF),
            padding: EdgeInsets.fromLTRB(0,8,500,0),
              ),
            ),*/

  }
}
