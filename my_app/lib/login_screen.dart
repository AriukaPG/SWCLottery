import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toString().trim(),
        password: _passwordController.text.toString().trim(),
      );
      // ignore: use_build_context_synchronously
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
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      } // Handle other exceptions
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/image2.png'),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Тавтай морилно уу?",
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
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
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
                child: Stack(
                  alignment: Alignment.centerRight, 
                  children: [
                    TextField(
                      controller: _passwordController, 
                      obscureText: _isObscured, 
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), 
                        border: InputBorder.none, 
                        hintText: 'Enter your password',
                      ), 
                      style: const TextStyle(
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
            const SizedBox(height: 20),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: const Color(0xffF58742),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: InkWell(
                  onTap: () => _login(context),
                  child: const Text(
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text(
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
