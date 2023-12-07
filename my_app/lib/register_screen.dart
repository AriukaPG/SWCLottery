import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body:SingleChildScrollView(
    child:Column( children: [
        Stack(children: [
          Image.asset('assets/images/image2.png'),
          Positioned.fill(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
          ),),
        ],),
      const SizedBox(height: 50),
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
              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                border: InputBorder.none,
                hintText: 'Бүтэн нэрээ оруулна уу?'
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ), 
      const SizedBox(height: 20), 
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
              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Имэйлээ оруулна уу?'
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ), 
      const SizedBox(height: 20), 
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
              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Нууц үгээ оруулаарай'
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ),
      const SizedBox(height: 20), 
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
              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  border: InputBorder.none,
                  hintText: 'Нууц үгээ давтан оруулаарай'
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ),
      const SizedBox(height: 40), 
      InkWell(
          onTap: () async {
            if (_passwordController.text == _confirmPasswordController.text) {
              try {
                UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text,
                );
                
                await userCredential.user!.updateDisplayName(
                  _nameController.text,
                );

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userCredential.user!.uid)
                    .set({
                  'uid': userCredential.user!.uid,
                  'displayName': _nameController.text,
                  'email': _emailController.text.trim(),
                });
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Амжилттай бүртгэгдлээ.\nНэвтрэх дээр дарж нэвтэрнэ үү."),
                    duration: Duration(seconds: 3),
                  ),
                );
              } catch (error) {
                if (kDebugMode) {
                  print("Error: $error");
                }
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
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
            color: const Color(0xffF58742),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
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
      const SizedBox(height: 30),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, 
        children: [
          const Text('Хэрэглэгчийн Эрх бий юу?'), 
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),);
              },
              child: const Text("Нэвтрэх", style: TextStyle(color: Color(0xffF58742))),
          ),
        ],
      ),
    ],),),);
  }
}
