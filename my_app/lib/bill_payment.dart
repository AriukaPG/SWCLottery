import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'billdetails_screen.dart';
import 'wallet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BillPaymentScreen extends StatefulWidget {

  const BillPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();

}
class _BillPaymentScreenState extends State<BillPaymentScreen>{
  bool showDefaultListTiles = true;
  bool button1=true;
  int selectedOption=1;
  String desc='';


  @override
  Widget build(BuildContext context){
   if(title=='Youtube'){
      desc='Youtube Premium\nfor one month with BCA OneKlik';
    }
   else{
     desc=title;
   }
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
             if(title!='Youtube')
             Positioned(top: 200,
                 left: 140,
                 child: Column(children: [

                     Image.asset(image),
                 SizedBox(height: 12),
                 Text('You will pay $desc',
                   style: TextStyle(fontSize: 16),)
                 ],),
             )
              else
                Positioned(top: 200,
                left: 180,
                child:Image.asset(image)),
                Positioned(top: 265,
                  left: 100,
                  child: Text('You will pay $desc',
                  style: TextStyle(fontSize: 16),)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30), // Adjust vertical padding here
                child: ListTile(
                  dense:true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: Text(
                    "Үнэ",
                    style: TextStyle(fontSize: 16, color: Color(0xff666666)),
                  ),
                  trailing: Text('$price', style: TextStyle(fontSize: 16),),

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ListTile(dense:true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: Text("",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: Text("Хураамж", style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff666666)
                  ),),
                  trailing: Text('$fee', style: TextStyle(fontSize: 16),),
                ),
              ),
              Divider(
                color: Colors.black,
                indent: 30.0,
                endIndent: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30), // Adjust vertical padding here
                child: ListTile(
                  dense:true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0),
                  title: Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: Text(
                    "Нийт",
                    style: TextStyle(fontSize: 16, color: Color(0xff666666)),
                  ),
                  trailing: Text('$total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 250),
              InkWell(
                onTap: () async{
                  try {
                    DateTime now = DateTime.now();
                    Timestamp timestamp = Timestamp.fromDate(now);
                    String stringTotal= total.toString();
                    DocumentReference transactionRef = await db.collection('transactions').add({
                      'userId': user,
                      'type': 'expense',
                      'amount': stringTotal,
                      'date': timestamp,
                      'title': title,
                    });
                    String transactionId = transactionRef.id;
                   // DateTime transactionDate = transactionRef.;
                    try {
                      await db.collection('upcomingBills').doc(billId).delete();
                      print('Document deleted successfully');
                    } catch (error) {
                      print('Error deleting document: $error');
                    }
                    print('Transaction added to Firestore successfully!');
                    Navigator.pushNamed(
                        context,"/wallet/billDetails/billPayment/confirm",
                  arguments: {'transactionId': transactionId,
                  'transactionDate': now,});
                  } catch (error) {
                    print('Error adding transaction to Firestore: $error');
                  }


                  //MaterialPageRoute(builder: (context) => RegisterScreen()),
                  //);
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors:  <Color>[Color(0xff63b4ae), Color(0xff438883)],
                    ),
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Center(
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