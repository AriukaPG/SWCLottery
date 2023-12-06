import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/wallet_screen.dart';
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
class AddExpenseScreen extends StatefulWidget {

  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();

}

class _AddExpenseScreenState extends State<AddExpenseScreen>{
  TextEditingController _amountController = TextEditingController();
  String selectedValue = 'Youtube'; // Default selected value
  bool tulburSelected= false;
  bool uniinSelected=false;

  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: Color(0xffFDFDFD),
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
                Positioned(top: 96,
                    right: 24,
                    child:  Icon(Icons.more_horiz,
                        color: Colors.white,
                        size: 25,
                      ),

                    ),
                const Positioned(child: const Text("Зарлага нэмэх",
                  style: TextStyle(color: Colors.white,
                      fontSize: 20),),
                  top: 95,
                  left: 130,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 180, 25, 0),
                  child: Container(
                          width: 358, // Adjust the size as needed
                          height: 450, // Set the same value as the width
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          // Change the color as desired
                        ),
                ),
                Positioned(top: 215,
                    left: 50,
                    child: Text("ГҮЙЛГЭЭНИЙ НЭР", style:
                    TextStyle(color:Color(0xff666666)),)),
                Positioned(
                  top: 240,
                    left: 50,
                    child:  Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffDDDDDD)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: DropdownButton<String>(
                            value: selectedValue,
                            elevation: 16,
                            underline: Container(
                                height: 2
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          icon: Padding(
                            padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                            child: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: Color(0xff888888)),
                          ), // Customized dropdown icon
                            items: <String>['Youtube', 'Netflix', 'Spotify','Electricity', 'House Rent','Шилжүүлэг']
                                .map<DropdownMenuItem<String>>((String value) {
                              Widget image;
                              if (value == 'Youtube') {
                                image = Image.asset('assets/images/youtube.png');
                              } else if (value == 'Netflix') {
                                image = Image.asset('assets/images/netflix.png');
                              }
                               else if (value == 'Spotify') {
                              image = Image.asset('assets/images/spotify.png');
                              }
                              else if (value == 'Electricity') {
                                image = Image.asset('assets/images/lightning.png');
                              }
                              else if (value == 'House Rent') {
                                image = Image.asset('assets/images/house.png');
                              }
                              else {
                                image = Image.asset('assets/images/woman.png');
                              }

                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    image,
                                    SizedBox(width: 8),
                                    Text(value, style: TextStyle(color: Color(0xff666666)),),

                                  ],

                                ),
                              );
                            }).toList(),
                          ),
                      ),

                    ),),
                Positioned(top: 315,
                    left: 50,
                    child: Text("ҮНИЙН ДҮН", style:
                    TextStyle(color:Color(0xff666666)),)),
              Positioned(
                top:340,
                left: 50,
                child:InkWell(
                    onTap: (){
                      setState(() {
                        uniinSelected=!uniinSelected;

                      });
                    },
                child:Container(
                width: 300, height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color:uniinSelected?
                  Color(0xff408E88):Color(0xffDDDDDD)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: TextField(
                    controller: _amountController,
                      style: TextStyle(color: Color(0xff408E88),
                          fontWeight: FontWeight.bold,
                      fontSize: 20),
                      decoration: InputDecoration(border: InputBorder.none),),
                ),

                )
                )
              ),
                Positioned(top: 415,
                    left: 50,
                    child: Text("ОГНОО", style:
                    TextStyle(color:Color(0xff666666)),)),
                Positioned(
                  top:440,
                    left: 50,
                    child:Container(
                    width: 300, height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDDDDDD)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: TextField(

                      style: TextStyle(color: Color(0xff666666),
                            //fontWeight: FontWeight.bold,
                            fontSize: 16),
                      //decoration: InputDecoration(border: InputBorder.none),
                      controller: datePickerController,
                      readOnly: true,
                     decoration: const InputDecoration(border: InputBorder.none,hintText: "Click here to select date"),
                      onTap: () => onTapFunction(context: context),
                    ),
                    )
                ),
                ),
                Positioned(top: 455,
                    right: 80,
                    child: Icon(Icons.date_range)),
                Positioned(top: 515,
                    left: 50,
                    child: Text("ТӨЛБӨР", style:
                    TextStyle(color:Color(0xff666666)),)),
                Positioned(
                  top:540,
                  left: 50,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                            tulburSelected=!tulburSelected;

                      });
                    },
                    child:
                    DottedBorder(
                      color: tulburSelected ?
                      Color(0xff408E88):Color(0xffDDDDDD),
                      strokeWidth: 1,
                      dashPattern: [5, 5],
                    child:InkWell(
                      onTap:  () async {
                        DateTime dateTime = DateTime.parse(datePickerController.text);
                        Timestamp timestamp = Timestamp.fromDate(dateTime);
                        await db.collection('upcomingBills').add({
                          'amount': _amountController.text,
                          'name': selectedValue,
                          'date': timestamp,
                          'userId': user,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Зарлага амжилттай нэмэгдлээ."),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        setState(() => _fetchLastFourBills(user));

                        _amountController.clear();
                        datePickerController.clear();
                        setState(() {
                          selectedValue = 'Youtube';
                          tulburSelected = false;
                          uniinSelected = false;
                        });
                      },
                      child: Container(
                        width:
                        300,
                        height: 50,
                        decoration: BoxDecoration(
                          //border: Border.all(color: Color(0xffDDDDDD)),
                          color:Colors.white
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //mainAxisSize:MainAxisSize.min,
                          children: [
                            Center(
                              child:Icon(Icons.add_circle,
                                color:  tulburSelected ?
                                Color(0xff408E88):Color(0xff666666),)),
                                  SizedBox(width: 20),
                                  Text("ТӨЛБӨР НЭМЭХ",
                                    style: TextStyle(color: tulburSelected ?
                                    Color(0xff408E88):Color(0xff666666),
                                        fontWeight: FontWeight.bold),
                                  ),


                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                ),

                ],),


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
              icon: Icon(Icons.bar_chart,
                  size: 30),
              onPressed: () {
    }
              ,
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
TextEditingController datePickerController = TextEditingController();
onTapFunction({required BuildContext context}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    lastDate: DateTime.now(),
    firstDate: DateTime(2015),
    initialDate: DateTime.now(),
  );
  if (pickedDate == null) return;
  datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
}

