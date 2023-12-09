import 'package:flutter/foundation.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          color:const Color(0xfff69457)
                      ),
                      child: const Icon(Icons.notifications_none,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                ),
                Positioned(top: 99,
                  right: 33,
                  child: Image.asset('assets/images/circle.png', width: 7,height: 7,),
                ),
                const Positioned(top: 95,
                  left: 110,child: Text("Түрийвч цэнэглэх",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20),),
                ),
                Column(
                  children: [
                    const SizedBox(height: 160,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        width: 415,
                        height: 127,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                      color: const Color(0xffF4F6F6),
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
                      width: 155,
                      height: 40,
                      decoration: BoxDecoration(
                        color: button2 ? Colors.white: const Color(0xffF4F6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
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
                        width: 155,
                        height: 40,
                        decoration: BoxDecoration(
                          color: button2 ? const Color(0xffF4F6F6):Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: InkWell(onTap: () {
                            Navigator.pushNamed(context, "/home");
                          },
                            child: const Text("Аккаунт",
                                style: TextStyle(color: Color(0xff666666),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),

            if(button2)
              Column(children: [
                Center(child: CreditCardWidget(
                  width: 324,
                  height: 209,
                  cardBgColor: const Color(0xff027F87),
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  onCreditCardWidgetChange: (CreditCardBrand brand) {},
                  glassmorphismConfig: Glassmorphism(
                    blurX: 0,
                    blurY: 0,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Color(0xfff69457), Color(0xfff69457)],
                    ),
                  ),
                ),),
                const Text("Картны мэдээлэлээ нэмэх", style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                const Text("Энд холбох  карт нь зөвхөн  таны нэр дээр\nбайх ёстой.", style: TextStyle(
                    color:Color(0xff666666)
                ),),
                CreditCardForm(
                  formKey: formKey,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (CreditCardModel data) {
                    setState(() {
                      cardNumber = cardNumber;
                      expiryDate = expiryDate;
                      cardHolderName =cardHolderName;
                      cvvCode = cvvCode;
                      isCvvFocused = isCvvFocused;
                    });
                  },
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  enableCvv: true,
                  cvvValidationMessage: 'Please input a valid CVV',
                  dateValidationMessage: 'Please input a valid date',
                  numberValidationMessage: 'Please input a valid number',

                  cardNumberValidator: (String? cardNumber) {
                    return null;
                  },
                  expiryDateValidator: (String? expiryDate) {
                    return null;
                  },
                  cvvValidator: (String? cvv) {
                    return null;
                  },
                  cardHolderValidator: (String? cardHolderName) {
                    return null;
                  },
                  onFormComplete: () {},
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
                const SizedBox(height:20),
                InkWell(
                  onTap: () async {
                    try {
                      await db.collection('cards').add({
                        'cardName': cardHolderName,
                        'cvv': cvvCode,
                        'expireDate': expiryDate,
                        'userId': user,
                      });
                    } catch (error) {
                      if (kDebugMode) {
                        print('Error adding credit card: $error');
                      }
                    }
                  },
                  child: Container(
                    width: 260,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff519792)
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
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
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: firstContainerSelected
                            ? const Color(0xffEDF4F3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            'Bank Link',
                            style: TextStyle(
                              color: firstContainerSelected
                                  ? const Color(0xff438883)
                                  : const Color(0xff888888),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Connect your bank account to deposit & fund',
                            style: TextStyle(
                              color: firstContainerSelected
                                  ? const Color(0xff438883)
                                  : const Color(0xff888888),
                            ),
                          ),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.food_bank_rounded,
                              color: firstContainerSelected
                                  ? const Color(0xff438883)
                                  : const Color(0xff888888),
                            ),
                          ),
                          trailing: firstContainerSelected
                              ? const Icon(Icons.check_circle, color: Color(0xff438883))
                              : const Text(''),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: secondContainerSelected
                            ? const Color(0xffEDF4F3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            'Microdeposits',
                            style: TextStyle(
                              color: secondContainerSelected
                                  ? const Color(0xff438883)
                                  : const Color(0xff888888),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Connect bank in 5-7 days',
                            style: TextStyle(
                                color: secondContainerSelected
                                    ? const Color(0xff438883)
                                    : const Color(0xff888888)
                            ),
                          ),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.currency_exchange,
                              color: secondContainerSelected
                                  ? const Color(0xff438883)
                                  : const Color(0xff888888),
                            ),
                          ),
                          trailing: secondContainerSelected
                              ? const Icon(Icons.check_circle, color: Color(0xff438883))
                              : const Text(''),
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
                    child: Container(
                        width: 344,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: BoxDecoration(
                          color: thirdContainerSelected? const Color(0xffEDF4F3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text('Paypal', style:
                            TextStyle(color:  thirdContainerSelected
                                ? const Color(0xff438883)
                                : const Color(0xff888888),
                                fontWeight: FontWeight.bold)),
                            subtitle: Text('Connect you paypal account', style:
                            TextStyle(
                                color: thirdContainerSelected
                                    ? const Color(0xff438883)
                                    : const Color(0xff888888)
                            )),
                            leading: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(Icons.paypal)
                            ),
                            trailing: thirdContainerSelected
                                ? const Icon(Icons.check_circle, color: Color(0xff438883))
                                : const Text(''),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 60),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 260,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xfff69457)
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
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
                  size: 30),
              onPressed: () {
                Navigator.pushNamed(context, "/lottery");
              },
            ),
            IconButton(
              icon: const Icon(Icons.wallet_outlined,
                  size: 30,
                  color: Color(0xffF58742)),
              onPressed: () {},
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
}