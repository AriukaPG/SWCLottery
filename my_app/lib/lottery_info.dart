import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
List<LotteryData> lotteries = [];
String lotteryName='';
int lotteryPrice=0;
String image='';
String lotteryId='';
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

      //setState(() {});
    } catch (error) {
      print('Error fetching lottery: $error');
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
                Image.asset('assets/images/image2.png'),
                Image.asset('assets/images/hee.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 95, 0, 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.chevron_left,
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
                          color:Color(0xfff69457)
                      ),
                      child: Icon(Icons.notifications_none,
                        color: Colors.white,
                        size: 25,
                      ),

                    )),
                Positioned(top: 99,
                  right: 33,
                  child: Image.asset('assets/images/Ellipse6.png', width: 7,height: 7,),
                ),
                Positioned(child: Text("Сугалааны мэдээлэл",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20),),
                  top: 95,
                  left: 110,
                ),
                Column(
                  children: [
                    SizedBox(height: 160,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        width: 415, // Adjust the size as needed
                        height: 127, // Set the same value as the width
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // Change the color as desired
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
                      color: Color(0xffF4F6F6),
                      borderRadius: BorderRadius.circular(30)

                    ),
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text("Search", style: TextStyle(color:Color(0xff666666)),),
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
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      children: [
                    SizedBox(height: 5),
                    ListTile(
                      title: Text(lottery.name, style:
                      TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold)),
                      subtitle: Text(_formatDate(lottery.date), style:
                      TextStyle(
                          color: Colors.black
                      )),
                      leading: Image.asset(lottery.image),
                      trailing: Text(lottery.price.toString()),
                      ),

                        ListTile(
                          title: Text(lottery.desc),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            lotteryName=lottery.name;
                            lotteryPrice=lottery.price;
                            date=_formatDate(lottery.date);
                            image=lottery.image;
                            lotteryId=lottery.id;
                            Navigator.pushNamed(
                              context,"/wallet/billDetails");
                          //MaterialPageRoute(builder: (context) => RegisterScreen()),
                          //);*/
                          },
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF58742),
                              borderRadius: BorderRadius.circular(30),
                              ),
                            child: Center(
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
                  SizedBox(height: 20)
                ],
              )


          ],
        ),
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
              icon: Icon(Icons.local_activity_outlined,
                  size: 30,
              color: Color(0xffF58742),),
              onPressed: () {

              }
            ),
            IconButton(
              icon: Icon(Icons.wallet_outlined,
                  size: 30,
                  ),
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
    final String name = data['name'];
    final int price = data['ticketPrice'];
    final Timestamp timestamp = data['date'];
    String icon = 'icon';
    String desc = data['desc'];
    switch (data['name']) {
      case 'Азын 10,000':
        icon = 'assets/images/upwork.png';
        break;
      case 'Топ сугалаа':
        icon = 'assets/images/youtube.png';
        break;
      default:
        icon = 'assets/images/woman.png';
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