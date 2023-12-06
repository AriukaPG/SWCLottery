import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/home_screen.dart';
import 'billdetails_screen.dart';
import 'wallet_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

String randomString ='';
class BillPaymentScreen2 extends StatefulWidget {

  const BillPaymentScreen2({Key? key}) : super(key: key);

  @override
  State<BillPaymentScreen2> createState() => _BillPaymentScreen2State();

}
class _BillPaymentScreen2State extends State<BillPaymentScreen2>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomString = generateRandomString(8);
  }
  Random random = Random();
  @override
  Widget build(BuildContext context){
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String transactionId = args['transactionId'];
    DateTime transactionDate = args['transactionDate'];
    String formattedDate = DateFormat('MMM d, yyyy').format(transactionDate);


// Format time
    String formattedTime = DateFormat.jm().format(transactionDate);
    return Scaffold(
      body: Column(
        children: [

          Stack(
            children: [
              Image.asset('assets/images/image2.png'),
              Image.asset('assets/images/hee.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 95, 0, 0),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () => Navigator.pushNamed(context, '/wallet'),

                    )
                  ],
                ),
              ),
              const Positioned(top: 95,
                left: 150,child: Text("Bill Payment",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20),),
              ),
              const Positioned(top: 96,
                right: 24,
                child:  Icon(Icons.more_horiz,
                  color: Colors.white,
                  size: 25,
                ),

              ),
              Column(
                children: [
                  const SizedBox(height: 160,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: 420, // Adjust the size as needed
                      height: 128, // Set the same value as the width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // Change the color as desired
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 190,
                  left: 100,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Амжилттай төлөгдлөө",
                  style: TextStyle(fontSize: 21, color: Color(0xff438883),
                      fontWeight: FontWeight.bold),),
                  Text('$title',style: TextStyle(fontSize: 15),),
                  SizedBox(height: 10),
                  Icon(Icons.check_circle, size: 30, color: Color(0xff438883),),
                  //SizedBox(height: 20),
                ]
                    ,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text(
                "Гүйлгээний дэлгэрэнгүй",
                style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 123),
              Icon(Icons.keyboard_arrow_up, color: Colors.black,)
            ],),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Төлбөрийн хэрэгсэл", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 123),
              Text(paymentMethod, style: TextStyle(fontSize: 16),)
            ],),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Төлөв", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 233),
              Text("Хийгдсэн", style: TextStyle(fontSize: 16, color: Color(0xff438883)),)
            ],),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Цаг", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 253),
              Text("$formattedTime", style: TextStyle(fontSize: 16),),
            ],),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Огноо", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 215),
              Text("$formattedDate", style: TextStyle(fontSize: 16),)
            ],),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Гүйлгээний дугаар", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 5),
              Text("$transactionId", style: TextStyle(fontSize: 16),),
              IconButton(
                icon: Icon(Icons.copy, color: Color(0xff438883)),
                onPressed: () {
                  FlutterClipboard.copy(transactionId)
                      .then((_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied to clipboard'),
                    ),
                  ));
                },
              ),
            ],),
          ),
          Divider(
            color: Colors.black,
            indent: 30.0,
            endIndent: 30.0,
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text(
                "Үнэ",
                style: TextStyle(fontSize: 16, color: Color(0xff666666)),
              ),
              SizedBox(width: 285),
              Text('$price', style: TextStyle(fontSize: 16),),
            ],),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text("Хураамж", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 245),
              Text('-  $fee', style: TextStyle(fontSize: 16),),
            ],),
          ),
          SizedBox(height: 12),
          Divider(
            color: Colors.black,
            indent: 30.0,
            endIndent: 30.0,
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              Text(
                "Нийт",
                style: TextStyle(fontSize: 16, color: Color(0xff666666)),
              ),
              SizedBox(width: 275),
              Text('$total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ],),
          ),

          QrImageView(
            data: randomString,
            version: QrVersions.auto,
            size: 120.0,
          ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  /*Navigator.pushNamed(
                        context,"/register");
                    //MaterialPageRoute(builder: (context) => RegisterScreen()),
                    //);*/
                },
                child: Container(
                  width: 260,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xff519792)
                    ),
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Center(
                    child: Text(
                      'Share receipt',
                      style: TextStyle(
                        color: Color(0xff519792),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                  ),
                ),
              ),
            ],




      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_filled,
                //color: //_selectedIndex == 0
                // Colors.white
                //: Colors.grey

                size: 30,),
              onPressed: () =>  Navigator.pushNamed(context,
                  "/home"),
            ),
            IconButton(
                icon: Icon(Icons.bar_chart,
                    size: 30),
                onPressed: () {

                }
            ),
            IconButton(
              icon: Icon(Icons.wallet_outlined,
                  size: 30,
                  color: Color(0xff3e7c78)),
              onPressed: () {
                print('Circular button pressed!');
              },
            ),
            IconButton(
              icon: Icon(Icons.person
                  ,
                  size: 30),
              onPressed: () {

                print('Circular button pressed!');
              },
            ),
          ],
        ),
      ),

    );
  }
}
String generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
        (_) => charset.codeUnitAt(random.nextInt(charset.length)),
  ));
}