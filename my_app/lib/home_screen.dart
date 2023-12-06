import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/firebase_options.dart';
import 'package:intl/intl.dart';
late DocumentSnapshot userSnapshot;
double balance=0;
double totalIncome=0;
double totalExpense=0;
String name = '';
int _selectedIndex = 0;
String user='';
List<TransactionData> transactions = [];
const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: Home',

  ),
  Text(
    'Index 1: Bar Chart',

  ),
  Text(
    'Index 2: Wallet',

  ),
  Text(
    'Index 3: User',

  ),
];

FirebaseFirestore db = FirebaseFirestore.instance;
class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late User? _user;
  @override
  void initState() {
    super.initState();
    balance=0;
    totalExpense=0;
    totalIncome=0;
    _user = FirebaseAuth.instance.currentUser;
    _fetchUserData();
    _fetchLastFourTransactions();
  }

  Future<void> _fetchUserData() async {
    if (_user != null) {
      try {
        userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (userSnapshot.exists) {
            name = userSnapshot['displayName'];
            user = userSnapshot['uid'];

            QuerySnapshot<Map<String, dynamic>> transactionsSnapshot =
                await FirebaseFirestore.instance
                .collection('transactions')
                .where('userId', isEqualTo: _user!.uid)
                .get();

            for (QueryDocumentSnapshot<Map<String, dynamic>> transaction
            in transactionsSnapshot.docs) {
              double amount = double.parse(transaction['amount']);
              String type = transaction['type'];

              if (type == 'income') {
                totalIncome += amount;
                //print(totalIncome);
              } else if (type == 'expense') {
                totalExpense += amount;
                //print(totalExpense);
;              }

            }
            setState(() {
              //totalIncome=totalIncome;
              balance=totalIncome-totalExpense;
            });
          //});
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }
  Future<void> _fetchLastFourTransactions() async {
    if (_user != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> transactionsSnapshot =
        await FirebaseFirestore.instance
            .collection('transactions')
            .where('userId', isEqualTo: _user!.uid)
            .orderBy('date', descending: true)
            .limit(4)
            .get();

        transactions = transactionsSnapshot.docs
            .map((doc) => TransactionData.fromMap(doc.data()))
            .toList();

        //setState(() {});
      } catch (error) {
        print('Error fetching last four transactions: $error');
      }
    }
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Bar Chart',
      style: optionStyle,
    ),
    Text(
      'Index 2: Wallet',
      style: optionStyle,
    ),
    Text(
      'Index 3: User',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Stack(children: [
            Image.asset('assets/images/image2.png'),
            Image.asset('assets/images/hee.png'),
            const Positioned(top: 74,
                left: 24,
                child: Text('Өглөөний мэнд?',
                style: TextStyle(
                  color: Colors.white,
                ),)),
            Positioned(top: 98,
                left: 24,
                child: Text('$name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),)),
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
            Column(
              children: [
                SizedBox(height: 150,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                  width: 400, // Adjust the size as needed
                  height: 190, // Set the same value as the width
                  decoration: BoxDecoration(
                      color: Color(0xfff69457),
                      borderRadius: BorderRadius.circular(20),
                    ),
                // Change the color as desired
                ),
                ),
              ],
            ),
          Positioned(
               top: 170,
                 left: 40,
                 child: Row(
                   children: [Text("Нийт үлдэгдэл",style: TextStyle(
                       fontSize: 18,
                       color: Colors.white
                   ),),
                     Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                   ],
                 )
          ),
          Positioned(
                top: 170,
                right: 40,
                child: Icon(Icons.more_horiz, color: Colors.white,),
            ),
         Positioned(
          top:200,
          left: 40,
          child: Text('$balance',
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              fontFamily: 'Inter-Regular'
            ),)
          ),
          Positioned(
                top:260,
                left: 40,
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF58742),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_downward, color:Colors.white, size:15,)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("  Орлого", style: TextStyle(color: Colors.white, fontSize: 15),)
                  ],
                )
            ),
          Positioned(
                top:290,
                left: 55,
                child: Text('$totalIncome',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Inter-Regular'
                  ),)
            ),
            Positioned(
                top:260,
                right: 55,
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF58742),
                      ),
                      child: Center(
                          child: Icon(Icons.arrow_upward, color:Colors.white, size:15,)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("  Зарлага", style: TextStyle(color: Colors.white, fontSize: 15),)
                  ],
                )
            ),
            Positioned(
                top:290,
                right: 55,
                child: Text('$totalExpense',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Inter-Regular'
                  ),)
            ),
          ],

          ),
          SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Гүйлгээний түүх", style:
                TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Text("Бүгдийг харах", style:
                TextStyle(fontSize: 16,
                   ),
              ),
              ),
            ],
          ),
          /*SizedBox(height: 10),
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
          ),*/
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
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Send Again", style:
                TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: Text("See All", style:
                TextStyle(fontSize: 16,
                  color: Color(0xff666666),
                ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/images7.png'),
                radius:25.0,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/image8.png'),
                radius: 25.0,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/images9.png'),
                radius: 25.0,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/images10.png'),
                radius: 25.0,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/image11.png'),
                radius: 25.0,
              ),
            ],
          ),

            ]

      ),

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_filled,
              color: //_selectedIndex == 0
                   Color(0xffF58742)
                  //: Colors.grey
                  ,
                size: 30,),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.local_activity_outlined,
                    size: 30),
                onPressed: (){
                  Navigator.pushNamed(context, '/lottery');
                },
              ),
              SizedBox(),
              IconButton(
                icon: Icon(Icons.wallet_outlined,
                    size: 30),
                onPressed: () =>  Navigator.pushNamed(context,
                    "/wallet"),
              ),
              IconButton(
                icon: Icon(Icons.person
                    ,
                    size: 30),
                onPressed: () {
                  // Add your action for the circular button here
                  // This will be triggered when the user taps on the circle button

                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action for the circular button here
            // This will be triggered when the user taps on the circle button
            Navigator.pushNamed(context,
                "/wallet/add");
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffF58742)
          ,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked

    );
  }
}
class TransactionData {
  final String title;
  final DateTime date;
  final String icon;
  final String amount;
  final Color amountColor;

  TransactionData({
    required this.title,
    required this.date,
    required this.icon,
    required this.amount,
    required this.amountColor,
  });

  factory TransactionData.fromMap(Map<String, dynamic> data) {
    final String type = data['type'];
    final double amount = double.parse(data['amount']);
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
      case 'House Rent':
        icon = 'assets/images/house.png';
        break;
      case 'Netflix':
        icon = 'assets/images/netflix.png';
        break;
      case 'Netflix':
        icon = 'assets/images/netflix.png';
        break;
      case 'Electricity':
      icon = 'assets/images/lightning.png';
      break;
      default:
        icon = 'assets/images/woman.png';
    }
    return TransactionData(
      title: data['name'] ?? '',
      date: timestamp.toDate(),
      icon: icon,
      amount: '${type == 'expense' ? '-' : '+'} $amount'.toString(),
      amountColor: type == 'expense' ? Colors.red : Colors.green,
    );
  }
}

String _formatDate(DateTime dateTime) {
  return DateFormat('MMM d, y HH:mm').format(dateTime);
}

