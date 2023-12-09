import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

List<LotteryData> lotteries = [];
String lotteryName='';
int lotteryPrice=0;
String image='';
String lotteryId='';
// ignore: prefer_typing_uninitialized_variables
var date;

class LotteryScreen extends StatefulWidget {

  const LotteryScreen({Key? key}) : super(key: key);

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen>{
  @override
  void initState() {
    super.initState();
    _fetchLotteries();
  }

  Future<void> _fetchLotteries() async {
    try {
      QuerySnapshot<Map<String, dynamic>> lotteriesSnapshot =
      await FirebaseFirestore.instance
          .collection('lotteries')
          .orderBy('date', descending: true)
          .limit(2)
          .get();
      lotteries = lotteriesSnapshot.docs
          .map((doc) => LotteryData.fromMap(doc.data(),doc.id))
          .toList();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching lottery: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context){
    _fetchLotteries();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        onTap: () => Navigator.pushNamed(context, '/wallet'),
                      )
                    ],
                  ),
                ),
                Positioned(top: 88,
                    right: 24,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:const Color(0xfff69457)
                      ),
                      child: const Icon(Icons.notifications_none,
                        color: Colors.white,
                        size: 25,
                      ),
                    )),
                Positioned(top: 99,
                  right: 33,
                  child: Image.asset('assets/images/circle.png', width: 7,height: 7,),
                ),
                const Positioned(
                  top: 95,
                  left: 110,
                  child: Text("Сугалааны мэдээлэл",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20),),
                ),
                Column(
                  children: [
                    const SizedBox(height: 160,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        width: 415,
                        height: 127,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(left: 45,
                  top:190,
                  child:
                  Container(
                    width: 315,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffF4F6F6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.search),
                      title: Text("Хайх", style: TextStyle(color:Color(0xff666666)),),
                    ),
                  ),
                ),
              ],
            ),
            for(var lottery in lotteries)
              Column(
                children: [
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: const Color(0xffF6F6F6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        ListTile(
                          title: Text(lottery.name, style:
                          const TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold)),
                          subtitle: Text(_formatDate(lottery.date), style:
                          const TextStyle(
                              color: Colors.black
                          )),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                                lottery.image, width: 50,height: 50,
                            ),
                          ),
                          trailing: Text('${lottery.price}₮'),
                        ),
                        ListTile(
                          title: Text(lottery.desc),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            lotteryName=lottery.name;
                            lotteryPrice=lottery.price;
                            date=_formatDate(lottery.date);
                            image=lottery.image;
                            lotteryId=lottery.id;
                            Navigator.pushNamed(
                                context,"/wallet/billDetails");
                          },
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffF58742),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'Худалдаж авах',
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
                  ),
                  const SizedBox(height: 20)
                ],
              )
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_filled,
                size: 30,),
              onPressed: () =>  Navigator.pushNamed(context, "/home"),
            ),
            IconButton(
                icon: const Icon(Icons.local_activity_outlined,
                  size: 30,
                  color: Color(0xffF58742),),
                onPressed: () {}
            ),
            IconButton(
              icon: const Icon(Icons.wallet_outlined,
                size: 30,
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

class LotteryData {
  final String name;
  final DateTime date;
  final String desc;
  final String image;
  final int price;
  final String id;

  LotteryData({
    required this.name,
    required this.date,
    required this.desc,
    required this.image,
    required this.price,
    required this.id
  });

  factory LotteryData.fromMap(Map<String, dynamic> data, String id) {
    final int price = data['ticketPrice'];
    final Timestamp timestamp = data['date'];
    String icon = 'icon';
    String desc = data['desc'];
    switch (data['name']) {
      case 'Азын 10,000':
        icon = 'assets/images/lucky.jpg';
        break;
      case 'Топ сугалаа':
        icon = 'assets/images/top.jpg';
        break;
      default:
        icon = 'assets/images/lottery.jpg';
    }
    return LotteryData(
      id:id,
      name: data['name'] ?? '',
      date: timestamp.toDate(),
      image: icon,
      price: price,
      desc: desc,
    );
  }
}

String _formatDate(DateTime dateTime) {
  return DateFormat('MMM d, y HH:mm').format(dateTime);
}