import 'package:flutter/material.dart';
import 'package:my_app/home_screen.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
class WalletAddScreen extends StatefulWidget {

  const WalletAddScreen({Key? key}) : super(key: key);

  @override
  State<WalletAddScreen> createState() => _WalletAddScreenState();

}
class _WalletAddScreenState extends State<WalletAddScreen>{
  bool firstContainerSelected = false;
  bool secondContainerSelected = false;
  bool thirdContainerSelected = false;

 bool button2=true;
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  int _selectedIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
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
                Positioned(child: Text("Түрийвч цэнэглэх",
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
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                      ),
                Positioned(
                  left: 50,
                  top: 195,
                  child: InkWell(
                    onTap:  () {
                      setState(() {

                        button2 = true;
                      });
                    },
                    child:

                  Container(
                    width:
                    155,
                    height: 40,
                    decoration: BoxDecoration(
                      color: button2 ? Colors.white: Color(0xffF4F6F6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text("Картууд",
                          style: TextStyle(color: Color(0xff666666),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                ),
                Positioned(
                    right: 50,
                    top: 195,
                    child:InkWell(
                      onTap:  () {
                        setState(() {

                          button2 = false;
                        });
                      },
                    child:
                    Container(
                      width:
                      155,
                      height: 40,
                      decoration: BoxDecoration(
                        color: button2 ? Color(0xffF4F6F6):Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: InkWell(onTap: () {
                          Navigator.pushNamed(context,
                              "/home");
                        },
                          child:
                          Text("Аккаунт",
                              style: TextStyle(color: Color(0xff666666),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ),
                    )
                ),
              ],
            ),
            /*
                    Center(
                      child: Container(
                        width: 260,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:  <Color>[Color(0xff027F87), Color(0xff57E3B9)],
                          ),
                        ),
                      ),
                    ),*/
            if(button2)
              Column(children: [
         Center(child: CreditCardWidget(
              width: 324,
              height: 209,
              cardBgColor: Color(0xff027F87),
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              //true when you want to show cvv(back) view
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
              glassmorphismConfig: Glassmorphism(
                blurX: 0,
                blurY: 0,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xfff69457), Color(0xfff69457)],
                ),
              ), // Callback for anytime credit card brand is changed
            ),),

           Text("Картны мэдээлэлээ нэмэх", style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
    Text("Энд холбох  карт нь зөвхөн  таны нэр дээр\nбайх ёстой.", style: TextStyle(
    color:Color(0xff666666)
    ),),

        CreditCardForm(
          formKey: formKey,
          // Required
          cardNumber: cardNumber,
          // Required
          expiryDate: expiryDate,
          // Required
          cardHolderName: cardHolderName,
          // Required
          cvvCode: cvvCode,
          // Required
          onCreditCardModelChange: (CreditCardModel data) {
            setState(() {
              cardNumber = cardNumber;
              expiryDate = expiryDate;
              cardHolderName =cardHolderName;
              cvvCode = cvvCode;
              isCvvFocused = isCvvFocused;
            });
          },
          // Required
          obscureCvv: true,
          obscureNumber: true,
          isHolderNameVisible: true,
          isCardNumberVisible: true,
          isExpiryDateVisible: true,
          enableCvv: true,
          cvvValidationMessage: 'Please input a valid CVV',
          dateValidationMessage: 'Please input a valid date',
          numberValidationMessage: 'Please input a valid number',

          cardNumberValidator: (String? cardNumber) {},
          expiryDateValidator: (String? expiryDate) {},
          cvvValidator: (String? cvv) {},
          cardHolderValidator: (String? cardHolderName) {
          },
          onFormComplete: () {
            // callback to execute at the end of filling card data
          },
          autovalidateMode: AutovalidateMode.always,
          disableCardNumberAutoFillHints: false,
          inputConfiguration: const InputConfiguration(
            cardNumberDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Картын дугаар',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            expiryDateDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Дуусах хугацаа',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Картын нэр',
            ),
            cardNumberTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cardHolderTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            expiryDateTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
            cvvCodeTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
                SizedBox(height:20),
                InkWell(
                  onTap: () async {
                    /*Navigator.pushNamed(
                        context,"/register");
                    //MaterialPageRoute(builder: (context) => RegisterScreen()),
                    //);*/
                    try {
                      await db.collection('cards').add({
                        'cardName': cardHolderName,
                        'cvv': cvvCode,
                        'expireDate': expiryDate,
                        'userId': user,
                      });

                      // Display a success message or navigate to another screen
                      print('Credit card added successfully!');
                    } catch (error) {
                      // Handle errors
                      print('Error adding credit card: $error');
                    }
                  },
                  child: Container(
                    width: 260,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff519792)
                      ),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Center(
                      child: Text(
                        'Нэмэх',
                        style: TextStyle(
                          color: Color(0xff519792),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                    ),
                  ),
                )
          ]
              )
            else if(!button2)
              Column(

              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      firstContainerSelected = !firstContainerSelected;
                      if (firstContainerSelected) {
                        secondContainerSelected = false;
                        thirdContainerSelected= false;
                      }
                    });
                  },
                  child: Container(
                    width: 344,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: firstContainerSelected
                          ? Color(0xffEDF4F3)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          'Bank Link',
                          style: TextStyle(
                            color: firstContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Connect your bank account to deposit & fund',
                          style: TextStyle(
                            color: firstContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888),
                          ),
                        ),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.food_bank_rounded,
                            color: firstContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888),
                          ),
                        ),
                        trailing: firstContainerSelected
                            ? Icon(Icons.check_circle, color: Color(0xff438883))
                            : Text(''),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      secondContainerSelected = !secondContainerSelected;
                      if (secondContainerSelected) {
                        firstContainerSelected = false;
                        thirdContainerSelected = false;
                      }
                    });
                  },
                  child: Container(
                    width: 344,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: secondContainerSelected
                      ? Color(0xffEDF4F3)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          'Microdeposits',
                          style: TextStyle(
                            color: secondContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Connect bank in 5-7 days',
                          style: TextStyle(
                            color: secondContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888)
                          ),
                        ),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.currency_exchange,
                            color: secondContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888),
                          ),
                        ),
                        trailing: secondContainerSelected
                            ? Icon(Icons.check_circle, color: Color(0xff438883))
                            : Text(''),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      thirdContainerSelected = !thirdContainerSelected;
                      if (secondContainerSelected) {
                        firstContainerSelected = false;
                        secondContainerSelected = false;
                      }
                    });
                  },
                  child:
                Container(
                    width: 344,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: thirdContainerSelected? Color(0xffEDF4F3)
        : Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text('Paypal', style:
                        TextStyle(color:  thirdContainerSelected
                            ? Color(0xff438883)
                            : Color(0xff888888),
                            fontWeight: FontWeight.bold)),
                        subtitle: Text('Connect you paypal account', style:
                        TextStyle(
                            color: thirdContainerSelected
                                ? Color(0xff438883)
                                : Color(0xff888888)
                        )),
                        leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.paypal)
                        ),
                        trailing: thirdContainerSelected
                            ? Icon(Icons.check_circle, color: Color(0xff438883))
                            : Text(''),

                      ),
                    )
                ),),

                /*Container(
                  width: 344,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: Color(0xffEDF4F3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Bank Link', style: TextStyle(
                        color: Color(0xff438883),fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text('Connect your bank account to deposit & fund',
                      style:TextStyle(
                      color: Color(0xff438883))),

                      leading: Container(
                          width: 60,
                          height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                          child: Icon(Icons.food_bank_rounded, color: Color(0xff438883),)
                      ),
                      trailing: Icon(Icons.check_circle, color: Color(0xff438883),),

                      onTap: () {
                        // Handle onTap event
                      },
                    ),
                  )
                ),
                SizedBox(height: 20),
                Container(
                    width: 344,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text('Microdeposits', style:
                        TextStyle(color: Color(0xff888888),
                            fontWeight: FontWeight.bold)),
                        subtitle: Text('Connect bank in 5-7 days', style:
                        TextStyle(
                            color: Color(0xff888888)
                        )),
                        leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.currency_exchange)
                        ),


                        onTap: () {
                          // Handle onTap event
                        },
                      ),
                    )
                ),
                SizedBox(height: 20),
                Container(
                    width: 344,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text('Paypal', style:
                        TextStyle(color: Color(0xff888888),
                        fontWeight: FontWeight.bold)),
                        subtitle: Text('Connect you paypal account', style:
                        TextStyle(
                          color: Color(0xff888888)
                        )),
                        leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.paypal)
                        ),


                        onTap: () {
                          // Handle onTap event
                        },
                      ),
                    )
                ),*/
                SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    /*Navigator.pushNamed(
                        context,"/register");
                    //MaterialPageRoute(builder: (context) => RegisterScreen()),
                    //);*/
                  },
                  child: Container(
                    width: 260,
                    height: 50,
                    decoration: BoxDecoration(
                     border: Border.all(
                       color: Color(0xfff69457)
                     ),
                      borderRadius: BorderRadius.circular(30),

                    ),
                    child: Center(
                      child: Text(
                        'Дараах',
                        style: TextStyle(
                          color: Color(0xfff69457),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                    ),
                  ),
                ),
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