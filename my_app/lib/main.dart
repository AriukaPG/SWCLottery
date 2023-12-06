import 'package:flutter/material.dart';
import 'package:my_app/bill_payment.dart';
import 'package:my_app/billdetails_screen.dart';
import 'package:my_app/home_screen.dart';
import 'package:my_app/login_screen.dart';
import 'package:my_app/register_screen.dart';
import 'package:my_app/walletAdd_screen.dart';
import 'splash_screen.dart';
import 'onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'bill_payment2.dart';
import 'lottery_info.dart';
import 'seeTicket_screen.dart';
import 'package:my_app/PushNotificationService.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//  await PushNotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Income and Expenses',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),//SplashScreen(),
        '/onboarding': (context) => const OnBoarding(),
        '/register':(context)=> const RegisterScreen(),
        '/login': (context)=> const LoginScreen(),
        '/home': (context)=> const HomeScreen(),
        '/lottery':(context)=> const LotteryScreen(),
        '/wallet/add': (context)=> const WalletAddScreen(),
        '/wallet/billDetails': (context)=> const BillDetailsScreen(),
        '/wallet/billDetails/billPayment': (context)=> const BillPaymentScreen(),
        '/wallet/billDetails/billPayment/confirm': (context)=> const BillPaymentScreen2(),
        '/wallet/billDetails/billPayment/confirm/seeTicket': (context)=> const SeeTicketScreen(),


      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
