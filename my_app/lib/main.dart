import 'package:flutter/material.dart';
import 'package:my_app/bill_payment.dart';
import 'package:my_app/billdetails_screen.dart';
import 'package:my_app/home_screen.dart';
import 'package:my_app/login_screen.dart';
import 'package:my_app/register_screen.dart';
import 'package:my_app/walletAdd_screen.dart';
import 'onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'bill_payment2.dart';
import 'lottery_info.dart';
import 'seeTicket_screen.dart';
import 'myAccount_screen.dart';
import 'package:my_app/splash_screen.dart';
import 'package:my_app/NetworkStatusListener.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final NetworkStatusListener networkStatusListener = NetworkStatusListener();
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    networkStatusListener.startListening(context);
    return MaterialApp(
      title: 'Сугалааны аппликейшн',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoarding(),
        '/register':(context)=> const RegisterScreen(),
        '/login': (context)=> const LoginScreen(),
        '/home': (context)=> const HomeScreen(),
        '/lottery':(context)=> const LotteryScreen(),
        '/wallet': (context)=> const WalletAddScreen(),
        '/wallet/billDetails': (context)=> const BillDetailsScreen(),
        '/wallet/billDetails/billPayment': (context)=> const BillPaymentScreen(),
        '/wallet/billDetails/billPayment/confirm': (context)=> const BillPaymentScreen2(),
        '/wallet/billDetails/billPayment/confirm/seeTicket': (context)=> const SeeTicketScreen(),
        '/account': (context)=> const MyAccountScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
