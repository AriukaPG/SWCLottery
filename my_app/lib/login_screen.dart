import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;


  Future<void> _login(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toString().trim(),
        password: _passwordController.text.toString().trim(),
      );
      // Navigate to the home screen or perform other actions upon successful login.
      Navigator.pushNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';

      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please check your email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address. Please enter a valid email.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This user account has been disabled.';
      } else {
        // Handle other error codes as needed
      }

      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print(e); // Handle other exceptions
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/image2.png'),
                Positioned.fill(
                  child: Column(
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
                    ],
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/images/image1.png',
              width: 250,
              height: 177,
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
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
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
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _passwordController,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                  ),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                IconButton(
                  icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
            SizedBox(height: 20),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: Color(0xffF58742),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: InkWell(
                  onTap: () => _login(context),
                  /*onTap: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                        .then((value) {
                      Navigator.pushNamed(context, "/home");
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                    Navigator.pushNamed(context, "/home");
                  },*/
                  child: Text(
                    "Нэвтрэх",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text(
                    "Бүртгүүлэх",
                    style: TextStyle(color: Color(0xffF58742)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}