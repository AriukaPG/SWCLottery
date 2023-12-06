import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'billdetails_screen.dart';
import 'lottery_info.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
List<BoughtTicketData> tickets = [];
class SeeTicketScreen extends StatefulWidget {

  const SeeTicketScreen({Key? key}) : super(key: key);

  @override
  State<SeeTicketScreen> createState() => _SeeTicketScreenState();

}
class _SeeTicketScreenState extends State<SeeTicketScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool showDefaultListTiles = true;
  bool button1=true;
  int selectedOption=1;
  String desc='';

  Future<void> _fetchLastTickets() async {
      try {
        QuerySnapshot<Map<String, dynamic>> transactionsSnapshot =
        await FirebaseFirestore.instance
            .collection('transactions')
            .where('userId', isEqualTo: user)
            .orderBy('date', descending: true)
            .limit(unit)
            .get();

        tickets = transactionsSnapshot.docs
            .map((doc) => BoughtTicketData.fromMap(doc.data()))
            .toList();

      } catch (error) {
        print('Error fetching last four transactions: $error');
      }
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
                      child: const Icon(Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () => Navigator.pushNamed(context, '/home'),

                    )
                  ],
                ),
              ),
              const Positioned(top: 95,
                left: 65,child: Text("Худалдан авсан сугалаа харах",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20),),
              ),
              Positioned(top: 96,
                right: 24,
                child:  Icon(Icons.more_horiz,
                  color: Colors.white,
                  size: 25,
                ),

              ),
              Column(
                children: [
                  SizedBox(height: 160,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: 420, // Adjust the size as needed
                      height: 160, // Set the same value as the width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // Change the color as desired
                    ),
                  ),
                ],
              ),
            ],
          ),
          for (var ticket in tickets)
            ListTile(
              title: Text(ticket.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffF0F6F5),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(child: Image.asset(ticket.image)),
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
                  color: Color(0xffF58742)),
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
class BoughtTicketData {
  final String name;
  final String image;


  BoughtTicketData({
    required this.name,
    required this.image,

  });

  factory BoughtTicketData.fromMap(Map<String, dynamic> data) {
    final String name = data['lotteryName'];
    //String ticketNumber= data['b']
    String image='';
    String desc = data['desc'];
    switch (data['name']) {
      case 'Азын 10,000':
        image = 'assets/images/upwork.png';
        break;
      case 'Топ сугалаа':
        image = 'assets/images/youtube.png';
        break;
      default:
        image = 'assets/images/woman.png';
    }
    return BoughtTicketData(
      name: data['lotteryName'] ?? '',
      image: image,
      //price: price,
    );
  }
}

String _formatDate(DateTime dateTime) {
  return DateFormat('MMM d, y HH:mm').format(dateTime);
}