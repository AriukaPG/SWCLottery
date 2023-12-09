import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'billdetails_screen.dart';
import 'lottery_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<int> randomTicketNumbers = [];
Random random=Random();
int randomIndex=0;
int randomTicketNumber=0;
String ticketDoc="";

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> getTicketNumbers(String transactionId) async {
    try {
      for (int i = 0; i < unit; i++) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('lotteries')
            .doc(lotteryId)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          if (data.containsKey('ticketNumbers') && data['ticketNumbers'] is List) {
            List<dynamic> ticketNumbers = data['ticketNumbers'];
            length = ticketNumbers.length;

            if (length > 0) {
              int randomIndex = (length == 1) ? 0 : random.nextInt(length - 1);

              randomTicketNumber = ticketNumbers.removeAt(randomIndex);
              randomTicketNumbers.add(randomTicketNumber);

              await updateLotteryTicketNumbers();
            }
          }
        } else {
          // Document not found
        }
      }

      if (randomTicketNumbers.isNotEmpty) {
        await addTicketToFirestore(transactionId);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document data: $e');
      }
    }
  }

  Future<void> updateLotteryTicketNumbers() async {
    await FirebaseFirestore.instance.collection('lotteries').doc(lotteryId).update({
      'ticketNumbers': FieldValue.arrayRemove(randomTicketNumbers),
    });
  }

  Future<void> addTicketToFirestore(String transactionId) async {
    try {
      DocumentReference ticketRef = await FirebaseFirestore.instance.collection('tickets').add({
        'userId': user,
        'lotteryId': lotteryId,
        'lotteryName': lotteryName,
        'boughtTickets': randomTicketNumbers,
        'transactionId': transactionId,
      });

      setState(() {
        ticketDoc = ticketRef.id;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating Firestore: $e');
      }
    }
  }

  Future<void> addValueToArray() async {
    try {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .update({
        'tickets': FieldValue.arrayUnion([...randomTicketNumbers])
      });

      print('Value added to the array successfully.');
    } catch (error) {
      print('Error adding value to the array: $error');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/background.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 95, 0, 0),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () => Navigator.pushNamed(context, '/wallet/billDetails'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: 420,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(top: 170,
                left: 90,
                child: Column(children: [
                  Image.asset(image, width: 80, height: 80,),
                  const SizedBox(height: 12),
                  Text('   Та $lotteryName сугалаанаас\n$unit ширхэг сугалаа авах гэж байна.',
                    style: const TextStyle(fontSize: 16),)
                ],),
              )],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListTile(
                  dense:true,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: const Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: const Text(
                    "Үнэ",
                    style: TextStyle(fontSize: 16, color: Color(0xff666666)),
                  ),
                  trailing: Text('$price', style: const TextStyle(fontSize: 16),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListTile(dense:true,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: const Text("",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: const Text("Хураамж", style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff666666)
                  ),),
                  trailing: Text('$fee', style: const TextStyle(fontSize: 16),),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 30.0,
                endIndent: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30), // Adjust vertical padding here
                child: ListTile(
                  dense:true,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: const Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: const Text(
                    "Нийт",
                    style: TextStyle(fontSize: 16, color: Color(0xff666666)),
                  ),
                  trailing: Text('$total', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(height: 250),
              InkWell(
                onTap: () async{
                  try {
                    randomTicketNumbers=[];
                    DateTime now = DateTime.now();
                    Timestamp timestamp = Timestamp.fromDate(now);
                    String stringTotal= total.toString();
                    DocumentReference transactionRef = await db.collection('transactions').add({
                      'userId': user,
                      'type': 'expense',
                      'amount': stringTotal,
                      'date': timestamp,
                      'title': lotteryName,
                      'paymentMethod': paymentMethod
                    });
                    String transactionId = transactionRef.id;
                    getTicketNumbers(transactionId);
                    addValueToArray();
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context,"/wallet/billDetails/billPayment/confirm",
                        arguments: {'transactionId': transactionId,
                          'transactionDate': now,});
                  } catch (error) {
                    if (kDebugMode) {
                      print('Error adding transaction to Firestore: $error');
                    }
                  }
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors:  <Color>[Color(0xffF58742), Color(0xffF58742)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Баталгаажуулах',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                icon: const Icon(Icons.local_activity_outlined,
                    size: 30,
                    color: Color(0xffF58742)),
                onPressed: () {}
            ),
            IconButton(
              icon: const Icon(Icons.wallet_outlined,
                  size: 30
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/wallet");
              },
            ),
            IconButton(
              icon: const Icon(Icons.person,
                  size: 30),
              onPressed: () {
                Navigator.pushNamed(context, "/account");
              },
            ),
          ],
        ),
      ),
    );
  }
}