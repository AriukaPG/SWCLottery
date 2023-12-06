import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'wallet_screen.dart';

double price=0;
double fee=0;
double total=0;
String paymentMethod='';

class BillDetailsScreen extends StatefulWidget {

  const BillDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();

}

class _BillDetailsScreenState extends State<BillDetailsScreen>{
  bool showDefaultListTiles = true;
  bool button1=true;
  int selectedOption=1;

  @override
  Widget build(BuildContext context){
    price = amount;
    fee=price*0.1;
    total=fee+price;
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
                left: 150,child: Text("Bill Details",
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
                      height: 126, // Set the same value as the width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // Change the color as desired
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 200, 0, 0),
                child: ListTile(
                    title: Text(title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    subtitle: Text(date),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration:
                      BoxDecoration(color: Color(0xffFFFFF),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                          child: Image.asset(image)
                      ),
                    ),
                  ),
              ),
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
                  trailing: Text('$total', style: TextStyle(fontSize: 16),),
                ),
              ),
              Text("Төлбөрийн хэрэгслээ сонго",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
              SizedBox(height: 20),
              Container(
                  width: 344,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: selectedOption==2?Color(0xffFAFAFA):Color(0xffEDF4F3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Дебит карт', style: TextStyle(
                          color:  selectedOption==1?Color(0xff438883):Color(0xff888888),fontWeight: FontWeight.bold
                      ),),
                      leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.credit_card, color: selectedOption==1?Color(0xff438883):Color(0xff888888),)
                      ),
                      trailing:Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        activeColor: selectedOption==1?Color(0xff438883):Color(0xff888888), // Change the active radio button color here
                        fillColor: MaterialStateProperty.all(selectedOption==1?Color(0xff438883):Color(0xff888888)),
                        splashRadius: 20, // Change the splash radius when clicked
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      onTap: () {
                        // Handle onTap event
                      },
                    ),
                  )
              ),
              SizedBox(height: 15),
              Container(
                  width: 344,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: selectedOption==1?Color(0xffFAFAFA):Color(0xffEDF4F3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Paypal', style: TextStyle(
                          color: selectedOption==2?Color(0xff438883):Color(0xff888888),fontWeight: FontWeight.bold
                      ),),
                      leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.paypal, color:selectedOption==2?Color(0xff438883):Color(0xff888888) ,)
                      ),
                      trailing:Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        activeColor: selectedOption==2?Color(0xff438883):Color(0xff888888), // Change the active radio button color here
                        fillColor: MaterialStateProperty.all(selectedOption==2?Color(0xff438883):Color(0xff888888)), // Change the fill color when selected
                        splashRadius: 20, // Change the splash radius when clicked
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),


                    ),
                  )
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (selectedOption == 1) {
                    paymentMethod = 'Дебит карт';
                  } else if (selectedOption == 2) {
                    paymentMethod = 'PayPal';
                  } else {
                    // Handle other options if needed
                    paymentMethod = 'Unknown Payment Method';
                  }
                  Navigator.pushNamed(
                      context,"/wallet/billDetails/billPayment" );
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
                      'Төлөх',
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