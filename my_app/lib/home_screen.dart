import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

late DocumentSnapshot userSnapshot;
double balance=0;
double totalIncome=0;
double totalExpense=0;
String name = '';
String user='';
List<TransactionData> transactions = [];

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
          name = userSnapshot['name'];
          user = userSnapshot['userId'];
          QuerySnapshot<Map<String, dynamic>> transactionsSnapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('userId', isEqualTo: _user!.uid)
              .get();
          for (QueryDocumentSnapshot<Map<String, dynamic>> transaction
          in transactionsSnapshot.docs) {
            double amount = double.parse(transaction['amount']);
            String type = transaction['type'];
            String paymentMethod=transaction['paymentMethod'];
            if (type == 'income' && paymentMethod == 'Balance') {
              totalIncome += amount;
            } else if (type == 'expense' && paymentMethod == 'Balance') {
              totalExpense += amount;
            }
          }
          setState(() {
            balance=totalIncome-totalExpense;
          });
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching user data: $error');
        }
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
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching last four transactions: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
            children: [
              Stack(children: [
                Image.asset('assets/images/background.png'),
                const Positioned(top: 74,
                    left: 24,
                    child: Text('Өглөөний мэнд?',
                      style: TextStyle(
                        color: Colors.white,
                      ),)),
                Positioned(top: 98,
                    left: 24,
                    child: Text(name,
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
                Column(
                  children: [
                    const SizedBox(height: 150,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 400, // Adjust the size as needed
                        height: 190, // Set the same value as the width
                        decoration: BoxDecoration(
                          color: const Color(0xfff69457),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                const Positioned(
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
                const Positioned(
                  top: 170,
                  right: 40,
                  child: Icon(Icons.more_horiz, color: Colors.white,),
                ),
                Positioned(
                    top:200,
                    left: 40,
                    child: Text('$balance',
                      style: const TextStyle(
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF58742),
                          ),
                          child: const Center(
                              child: Icon(Icons.arrow_downward, color:Colors.white, size:15,)
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text("  Орлого", style: TextStyle(color: Colors.white, fontSize: 15),)
                      ],
                    )
                ),
                Positioned(
                    top:290,
                    left: 55,
                    child: Text('$totalIncome',
                      style: const TextStyle(
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF58742),
                          ),
                          child: const Center(
                              child: Icon(Icons.arrow_upward, color:Colors.white, size:15,)
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text("  Зарлага", style: TextStyle(color: Colors.white, fontSize: 15),)
                      ],
                    )
                ),
                Positioned(
                    top:290,
                    right: 55,
                    child: Text('$totalExpense',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Inter-Regular'
                      ),)
                ),
              ],),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Гүйлгээний түүх", style:
                    TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                    child: Text("Бүгдийг харах", style:
                    TextStyle(fontSize: 16,
                    ),
                    ),
                  ),
                ],
              ),
              for (var transaction in transactions)
                    ListTile(
                      title: Text(transaction.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(_formatDate(transaction.date)),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xffF0F6F5),
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
              const SizedBox(height: 20),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Дахин илгээх", style:
                    TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image1.png'),
                    radius:25.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image2.png'),
                    radius: 25.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image3.png'),
                    radius: 25.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image4.png'),
                    radius: 25.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image5.png'),
                    radius: 25.0,
                  ),
                ],
              ),
            ]
        ),

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_filled,
                  color: Color(0xffF58742),
                  size: 30,),
                onPressed: (){},
              ),
              IconButton(
                icon: const Icon(Icons.local_activity_outlined,
                    size: 30),
                onPressed: (){
                  Navigator.pushNamed(context, '/lottery');
                },
              ),
              IconButton(
                icon: const Icon(Icons.wallet_outlined,
                    size: 30),
                onPressed: () =>  Navigator.pushNamed(context, "/wallet"),
              ),
              IconButton(
                icon: const Icon(Icons.person,
                    size: 30),
                onPressed: () =>  Navigator.pushNamed(context, "/account"),
              ),
            ],
          ),
        ),
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
    switch (data['title']) {
      case 'Азын 10,000':
        icon = 'assets/images/lucky.jpg';
        break;
      case 'Топ сугалаа':
        icon = 'assets/images/top.jpg';
        break;
      default:
        icon = 'assets/images/lottery.jpg';
    }
    return TransactionData(
      title: data['title'] ?? '',
      date: timestamp.toDate(),
      icon: icon,
      amount: '${type == 'expense' ? '-' : '+'} $amount'.toString(),
      amountColor: type == 'expense' ? Colors.red : Colors.green,
    );
  }
}

String _formatDate(DateTime dateTime) {
  return DateFormat('MMM d, y HH:mm').format(dateTime);
}/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

late DocumentSnapshot userSnapshot;
double balance = 0;
double totalIncome = 0;
double totalExpense = 0;
String name = '';
String user = '';
List<TransactionData> transactions = [];
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
    switch (data['title']) {
      case 'Азын 10,000':
        icon = 'assets/images/lucky.jpg';
        break;
      case 'Топ сугалаа':
        icon = 'assets/images/top.jpg';
        break;
      default:
        icon = 'assets/images/lottery.jpg';
    }
    return TransactionData(
      title: data['title'] ?? '',
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
    balance = 0;
    totalExpense = 0;
    totalIncome = 0;
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Please wait..."),
                ],
              ),
            );
          } else {
            return _buildHomeScreen();
          }
        },
      ),
    );
  }

  Future<void> _fetchData() async {
    await _fetchUserData();
    await _fetchLastFourTransactions();
  }

  Widget _buildHomeScreen() {
    return Scaffold(
      body:Column(
      children: [
        Stack(
          children: [
            Image.asset('assets/images/background.png'),
            Positioned(
              top: 74,
              left: 24,
              child: Text(
                'Өглөөний мэнд?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 98,
              left: 24,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 88,
              right: 24,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xfff69457),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              top: 99,
              right: 33,
              child: Image.asset(
                'assets/images/circle.png',
                width: 7,
                height: 7,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 150,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 400,
                    height: 190,
                    decoration: BoxDecoration(
                      color: const Color(0xfff69457),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 170,
              left: 40,
              child: Row(
                children: [
                  Text(
                    "Нийт үлдэгдэл",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            const Positioned(
              top: 170,
              right: 40,
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
            Positioned(
              top: 200,
              left: 40,
              child: Text(
                '$balance',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Inter-Regular',
                ),
              ),
            ),
            Positioned(
              top: 260,
              left: 40,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF58742),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_downward, color: Colors.white, size: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "  Орлого",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            Positioned(
              top: 290,
              left: 55,
              child: Text(
                '$totalIncome',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter-Regular',
                ),
              ),
            ),
            Positioned(
              top: 260,
              right: 55,
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF58742),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_upward, color: Colors.white, size: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "  Зарлага",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            Positioned(
              top: 290,
              right: 55,
              child: Text(
                '$totalExpense',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter-Regular',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Гүйлгээний түүх",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
              child: Text(
                "Бүгдийг харах",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        for (var transaction in transactions)
          ListTile(
            title: Text(transaction.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(_formatDate(transaction.date)),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffF0F6F5),
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
        const SizedBox(height: 20),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Дахин илгээх",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image1.png'),
              radius: 25.0,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image2.png'),
              radius: 25.0,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image3.png'),
              radius: 25.0,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image4.png'),
              radius: 25.0,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image5.png'),
              radius: 25.0,
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
    icon: const Icon(
    Icons.home_filled,
    color: Color(0xffF58742),
    size: 30,
    ),
    onPressed: () {},
    ),
    IconButton(
    icon: const Icon(Icons.local_activity_outlined, size: 30),
    onPressed: () {
    Navigator.pushNamed(context, '/lottery');
    },
    ),
    IconButton(
    icon: const Icon(Icons.wallet_outlined, size: 30),
    onPressed: () => Navigator.pushNamed(context, "/wallet"),
    ),
    IconButton(
    icon: const Icon(Icons.person, size: 30),
    onPressed: () => Navigator.pushNamed(context, "/account"),
    ),
    ],
    ),
    ),
    );
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
            } else if (type == 'expense') {
              totalExpense += amount;
            }
          }
          setState(() {
            balance=totalIncome-totalExpense;
          });
        }
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching user data: $error');
        }
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
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching last four transactions: $error');
        }
      }
    }
    }
  }
*/