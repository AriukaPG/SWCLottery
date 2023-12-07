import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/lottery_info.dart';
import 'billdetails_screen.dart';
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
                left: 150,child: Text("Төлбөр төлөх",
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
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: 420, // Adjust the size as needed
                      height: 128, // Set the same value as the width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
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
                  const Text("Амжилттай төлөгдлөө",
                  style: TextStyle(fontSize: 21, color: Color(0xffF58742),
                      fontWeight: FontWeight.bold),),
                  Text(lotteryName,style: const TextStyle(fontSize: 15),),
                  const SizedBox(height: 10),
                  const Icon(Icons.check_circle, size: 30, color: Color(0xffF58742),),
                ],)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: const [
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text("Төлбөрийн хэрэгсэл", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              const SizedBox(width: 123),
              Text(paymentMethod, style: const TextStyle(fontSize: 16),)
            ],),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: const [
              Text("Төлөв", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              SizedBox(width: 233),
              Text("Хийгдсэн", style: TextStyle(fontSize: 16, color: Color(0xffF58742)),)
            ],),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text("Цаг", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              const SizedBox(width: 253),
              Text(formattedTime, style: const TextStyle(fontSize: 16),),
            ],),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text("Огноо", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              const SizedBox(width: 215),
              Text(formattedDate, style: const TextStyle(fontSize: 16),)
            ],),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text("Гүйлгээний дугаар", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              const  SizedBox(width: 5),
              Text(transactionId, style: const TextStyle(fontSize: 16),),
              IconButton(
                icon: const Icon(Icons.copy, color: Color(0xffF58742)),
                onPressed: () {
                  FlutterClipboard.copy(transactionId)
                      .then((_) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                    ),
                  ));
                },
              ),
            ],),
          ),
          const Divider(
            color: Colors.black,
            indent: 30.0,
            endIndent: 30.0,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text(
                "Үнэ",
                style: TextStyle(fontSize: 16, color: Color(0xff666666)),
              ),
              const SizedBox(width: 285),
              Text('$price', style: const TextStyle(fontSize: 16),),
            ],),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text("Хураамж", style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff666666)
              ),),
              const SizedBox(width: 245),
              Text('-  $fee', style: const TextStyle(fontSize: 16),),
            ],),
          ),
          const SizedBox(height: 12),
          const Divider(
            color: Colors.black,
            indent: 30.0,
            endIndent: 30.0,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(children: [
              const Text(
                "Нийт",
                style: TextStyle(fontSize: 16, color: Color(0xff666666)),
              ),
              const SizedBox(width: 275),
              Text('$total', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ],),
          ),
          QrImageView(
            data: randomString,
            version: QrVersions.auto,
            size: 120.0,
          ),
          const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                        context,'/wallet/billDetails/billPayment/confirm/seeTicket');
                },
                child: Container(
                  width: 260,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xffF58742)
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Сугалааны дугаар харах',
                      style: TextStyle(
                        color: Color(0xffF58742),
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
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_filled,
                    size: 30,),
                    onPressed: () =>  Navigator.pushNamed(context,"/home"),
            ),
            IconButton(
                icon: const Icon(Icons.bar_chart,
                    size: 30),
                    onPressed: () {}
            ),
            IconButton(
              icon: const Icon(Icons.wallet_outlined,
                  size: 30,
                  color: Color(0xff3e7c78)),
                  onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person,
                  size: 30),
                  onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
