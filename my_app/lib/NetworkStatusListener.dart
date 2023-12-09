import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NetworkStatusListener {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();

  void startListening(BuildContext context) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // No internet connection, check if the user is logged in and log out
        _checkAndLogout(context);
      }
    });
  }

  Future<void> _checkAndLogout(BuildContext context) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, '/login');
        //Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login');
        // Use rootNavigator: true to ensure that the root navigator is used
        print('User logged out due to no internet connection.');
      } catch (e) {
        print("Error logging out: $e");
      }
    }
  }
}
