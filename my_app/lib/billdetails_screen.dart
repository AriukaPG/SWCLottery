import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'lottery_info.dart';

int price=0;
double fee=0;
double total=0;
String paymentMethod='';
int unit=0;
int length=0;

class BillDetailsScreen extends StatefulWidget {

  const BillDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen>{
  @override
  void initState() {
    super.initState();
    _unitController.addListener(_updateTotal);
  }

  final TextEditingController _unitController = TextEditingController();
  int selectedOption=1;

  void _updateTotal() async{
    setState((){
      int l1 = int.tryParse(_unitController.text) ?? 0;
      price = lotteryPrice * l1;
      fee = price * 0.1;
      total = fee + price;
      unit = l1;
     check();

    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(child:
      Column(
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
                      onTap: () => Navigator.pushNamed(context, '/lottery'),
                    )
                  ],
                ),
              ),
              const Positioned(top: 95,
                left: 150,child: Text("Bill Details",
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
                      width: 420, // Adjust the size as needed
                      height: 120, // Set the same value as the width
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 180, 0, 0),
                child: ListTile(
                  title: Text(lotteryName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  subtitle: Text(date),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration:
                    BoxDecoration(color: const Color(0x0fffffff),
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
          InkWell(
              onTap: (){
                setState(() {
                });
              },
              child:Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color:const Color(0xffDDDDDD)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: TextField(
                    controller: _unitController,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15),
                    decoration: const InputDecoration(border: InputBorder.none,
                        hintText: 'Та хэдэн ширхэг сугалаа авах вэ?'),),
                ),
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30), // Adjust vertical padding here
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
                  trailing: Text('$total', style: const TextStyle(fontSize: 16),),
                ),
              ),
              const Text("Төлбөрийн хэрэгслээ сонго",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
              ),
              const SizedBox(height: 20),
              Container(
                  width: 344,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: selectedOption==2?const Color(0xffFAFAFA):const Color(0xffEDF4F3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Дебит карт', style: TextStyle(
                          color:  selectedOption==1?const Color(0xffF58742):const Color(0xff888888),fontWeight: FontWeight.bold
                      ),),
                      leading: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.credit_card, color: selectedOption==1?const Color(0xffF58742):const Color(0xff888888),)
                      ),
                      trailing:Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        activeColor: selectedOption==1?const Color(0xffF58742):const Color(0xff888888), // Change the active radio button color here
                        fillColor: MaterialStateProperty.all(selectedOption==1?const Color(0xffF58742):const Color(0xff888888)),
                        splashRadius: 20, // Change the splash radius when clicked
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });},),
                      onTap: () {},
                    ),
                  )
              ),
              const SizedBox(height: 15),
              Container(
                  width: 344,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: selectedOption==1?const Color(0xffFAFAFA):const Color(0xffEDF4F3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Дансны үлдэгдэл', style: TextStyle(
                          color: selectedOption==2?const Color(0xffF58742):const Color(0xff888888),fontWeight: FontWeight.bold
                      ),),
                      leading: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.account_balance_wallet, color:selectedOption==2?const Color(0xffF58742):const Color(0xff888888) ,)
                      ),
                      trailing:Radio<int>(
                        value: 2,
                        groupValue: selectedOption,
                        activeColor: selectedOption==2?const Color(0xffF58742):const Color(0xff888888),
                        fillColor: MaterialStateProperty.all(selectedOption==2?const Color(0xffF58742):const Color(0xff888888)), // Change the fill color when selected
                        splashRadius: 20, // Change the splash radius when clicked
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });},
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (selectedOption == 1) {
                    paymentMethod = 'Дебит карт';
                  } else if (selectedOption == 2) {
                    paymentMethod = 'Дансны үлдэгдэл';
                  } else {
                    paymentMethod = 'Unknown Payment Method';
                  }
                  if(length>=unit){
                  Navigator.pushNamed(
                      context,"/wallet/billDetails/billPayment" );
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Уучлаарай, $length ширхэг сугалаа байна'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF58742),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
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

  Future<void> check() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('lotteries')
        .doc(lotteryId)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('ticketNumbers') &&
          data['ticketNumbers'] is List) {
        List<dynamic> ticketNumbers = data['ticketNumbers'];
        length = ticketNumbers.length;
        print(length);
        if (length < unit) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Уучлаарай, $length ширхэг сугалаа байна'),
              duration: const Duration(seconds: 3),
            ),
          );
        }

        if(length==0){
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Уучлаарай, сугалааны тасалбар дууссан байна'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }
}