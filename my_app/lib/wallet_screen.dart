import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
List<BillData> upcomingBills = [];
String title='';
double amount=0;
String image='';
String billId='';
var date;
Future<void> _fetchLastFourBills(String user) async {
  if (user != null) {
    try {
      QuerySnapshot<Map<String, dynamic>> billsSnapshot =
      await FirebaseFirestore.instance
          .collection('upcomingBills')
          .where('userId', isEqualTo: user)
          .orderBy('date', descending: true)
          .limit(4)
          .get();

      upcomingBills = billsSnapshot.docs
          .map((doc) => BillData.fromMap(doc.id, doc.data()))
          .toList();


      //setState(() {});
    } catch (error) {
      print('Error fetching last four bills: $error');
    }
  }
}
class WalletScreen extends StatefulWidget {

  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();

}
String _formatDate(DateTime dateTime) {
  return DateFormat('MMM d, y HH:mm').format(dateTime);
}
class _WalletScreenState extends State<WalletScreen>{
  bool showDefaultListTiles = true;
  bool button1=true;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLastFourBills(user);
  }
  @override
  Widget build(BuildContext context){
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
                        child: Icon(Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () => Navigator.pushNamed(context, '/home'),

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
                          color:Color(0xff408E88)
                      ),
                      child: Icon(Icons.notifications_none,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                ),
                Positioned(top: 99,
                  right: 33,
                  child: Image.asset('assets/images/Ellipse6.png', width: 7,height: 7,),
                ),
                Positioned(child: Text("Түрийвч",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20),),
                  top: 95,
                  left: 150,
                ),
                Column(
                  children: [
                    SizedBox(height: 160,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        width: 410, // Adjust the size as needed
                        height: 305, // Set the same value as the width
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
                  top: 200,
                  left: 90,
                  child: Column(
                    children: [
                      Text(
                        "Нийт үлдэгдэл",
                        style: TextStyle(color: Color(0xff666666), fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$balance',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/wallet/addExpense'),
                            child: Column(
                              children: [
                                Image.asset('assets/images/frame21.png'),
                                SizedBox(height: 5,),
                                Text('Нэмэх'),
                              ],
                            ),
                          ),
                          SizedBox(width: 23),
                          InkWell(
                            //onTap: () => Navigator.pushNamed(context, '/'),
                            child: Column(
                              children: [
                                Image.asset('assets/images/frame22.png'),
                                SizedBox(height: 5,),
                                Text('Төлөх'),
                              ],
                            ),
                          ),
                          SizedBox(width: 23),
                          InkWell(
                            //onTap: () => Navigator.pushNamed(context, '/'),
                            child: Column(
                              children: [
                                Image.asset('assets/images/frame23.png'),
                                SizedBox(height: 5,),
                                Text('Илгээх'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(height: 8,),
                    ],
                  ),
                ),

                //SizedBox(height: 10,),
                Positioned(left: 25,
                  top:410,
                  child:
                  Container(
                    width: 360,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffF4F6F6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 415,
                  child:
                  InkWell(
                    onTap: (){
                      setState(() {
                        showDefaultListTiles = true;
                        button1=true;
                      });
                    },
                    child:
                    Container(
                      width:
                      170,
                      height: 40,
                      decoration: BoxDecoration(
                        color: showDefaultListTiles ? Colors.white: Color(0xffF4F6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text("Гүйлгээнүүд",
                            style: TextStyle(color: Color(0xff666666),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  top: 415,
                  child:InkWell(
                    onTap:  () {
                      setState(() {
                        showDefaultListTiles = !showDefaultListTiles;
                        button1 = false;
                      });
                    },
                    child:
                    Container(
                        width:
                        170,
                        height: 40,
                        decoration: BoxDecoration(
                          color:  showDefaultListTiles ? Color(0xffF4F6F6):Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:Center(
                          child:  Text("Хүлээгдэж буй гүйлгээ",
                              style: TextStyle(color: Color(0xff666666),
                                  fontWeight: FontWeight.bold)),
                        )

                    ),
                  ),
                ),
              ],
            ),
            if (showDefaultListTiles && button1)
              Column(
                children: [
                  for (var transaction in transactions)
                    ListTile(
                      title: Text(transaction.title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(_formatDate(transaction.date)),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xffF0F6F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Image.asset(transaction.icon)),
                      ),
                      trailing: Text(
                        transaction.amount,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: transaction.amountColor,
                        ),
                      ),
                    ),
                ],
              )
          /*Column(children: [
            ListTile(
              title: Text("Upwork",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text("Өнөөдөр"),
              leading: Container(
                width: 50,
                height: 50,
                decoration:
                BoxDecoration(color: Color(0xffF0F6F5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                    child: Image.asset("assets/images/upwork.png")
                ),
              ),
              trailing: Text("+ 850.0", style:
              TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff25A969)),
              ),
            ),
            ListTile(
              title: Text("Шилжүүлэг",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text("Өчигдөр"),
              leading: Container(
                width: 50,
                height: 50,
                decoration:
                BoxDecoration(color: Color(0xffF0F6F5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                    child: Image.asset("assets/images/woman.png")
                ),
              ),
              trailing: Text("- 85.0",
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF95B51)),
              ),
            ),
            ListTile(
              title: Text("Paypal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text("Jan 30, 2022"),
              leading: Container(
                width: 50,
                height: 50,
                decoration:
                BoxDecoration(color: Color(0xffF0F6F5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                    child: Image.asset("assets/images/paypal.png")
                ),
              ),
              trailing: Text("+ 1406.0", style:
              TextStyle(fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff25A969)),
              ),
            ),
            ListTile(
              title: Text("Youtube",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text("Jan 16, 2022"),
              leading: Container(
                width: 50,
                height: 50,
                decoration:
                BoxDecoration(color: Color(0xffF0F6F5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                    child: Image.asset("assets/images/youtube.png")
                ),
              ),
              trailing: Text("- 11.99",
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF95B51)),
              ),
            ),
          ],)*/
            else if(!showDefaultListTiles && !button1)
              Column(
            children: [/*
              ListTile(
                title: Text("Youtube",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Text("Feb 28, 2022"),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration:
                  BoxDecoration(color: Color(0xffF0F6F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                      child: Image.asset("assets/images/youtube.png")
                  ),
                ),
                trailing: InkWell(
                    child: Container(
                          width: 90,
                          height: 40,
                          decoration: BoxDecoration(color: Color(0xffECF9F8),
                              borderRadius: BorderRadius.circular(20)
                          ),
                            child: Center(
                                child: Text("Төлөх", style: TextStyle(color: Color(0xff438883),
                                fontSize: 17),),
                            ),
                        )
                      ),
              ),
              ListTile(
                title: Text("Electricity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Text("Mar 28, 2022"),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration:
                  BoxDecoration(color: Color(0xffF0F6F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                      child: Image.asset("assets/images/lightning.png")
                  ),
                ),
                trailing: InkWell(
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(color: Color(0xffECF9F8),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text("Төлөх", style: TextStyle(color: Color(0xff438883),
                            fontSize: 17),),
                      ),
                    )
                ),
              ),
              ListTile(
                title: Text("House rent",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Text("Mar 31, 2022"),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration:
                  BoxDecoration(color: Color(0xffF0F6F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                      child: Image.asset("assets/images/house.png")
                  ),
                ),
                trailing: InkWell(
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(color: Color(0xffECF9F8),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text("Төлөх", style: TextStyle(color: Color(0xff438883),
                            fontSize: 17),),
                      ),
                    )
                ),
              ),
              ListTile(
                title: Text("Spotify",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Text("Feb 28, 2022"),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration:
                  BoxDecoration(color: Color(0xffF0F6F5),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                      child: Image.asset("assets/images/spotify.png")
                  ),
                ),
                trailing: InkWell(
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(color: Color(0xffECF9F8),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text("Төлөх", style: TextStyle(color: Color(0xff438883),
                            fontSize: 17),),
                      ),
                    )
                ),
              ),*/
              for (var bill in upcomingBills)
                ListTile(
                  title: Text(bill.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  subtitle: Text(_formatDate(bill.date)),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration:
                    BoxDecoration(color: Color(0xffF0F6F5),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                        child: Image.asset(bill.icon)
                    ),
                  ),
                  trailing: InkWell(
                    onTap: (){
                      title=bill.title;
                      date=_formatDate(bill.date);
                      image=bill.icon;
                      amount=bill.amount;
                      billId=bill.id;
                      Navigator.pushNamed(context, '/wallet/billDetails');
                    },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(color: Color(0xffECF9F8),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("Төлөх", style: TextStyle(color: Color(0xff438883),
                              fontSize: 17),),
                        ),
                      )
                  ),
                ),

            ],
          )

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
              onPressed: () => _onItemTapped(1),
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
class BillData {
  final String id;
  final String title;
  final DateTime date;
  final String icon;
  final double amount;
  //final Color amountColor;

  BillData({
    required this.id,
    required this.title,
    required this.date,
    required this.icon,
    required this.amount,
    //required this.amountColor,
  });

  factory BillData.fromMap(String id,Map<String, dynamic> data) {
    //final String type = data['type'];
    double amount= double.parse(data['amount']);
    final Timestamp timestamp = data['date'];
    String icon = 'icon';
    switch (data['name']) {
      case 'Upwork':
        icon = 'assets/images/upwork.png';
        break;
      case 'Шилжүүлэг':
        icon = 'assets/images/woman.png';
        break;
      case 'Paypal':
        icon = 'assets/images/paypal.png';
        break;
      case 'Youtube':
        icon = 'assets/images/youtube.png';
        break;
      case 'Spotify':
        icon = 'assets/images/spotify.png';
        break;
      case 'Netflix':
        icon = 'assets/images/netflix.png';
      case 'House Rent':
        icon = 'assets/images/lightning.png';
        break;
      default:
        icon = 'assets/images/woman.png';
    }
    return BillData(
      id: id,
      title: data['name'] ?? '',
      date: timestamp.toDate(),
      icon: icon,
      amount: amount,
      //amountColor: type == 'expense' ? Colors.red : Colors.green,
    );

  }
}