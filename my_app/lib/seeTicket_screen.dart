import 'package:flutter/material.dart';
import 'package:my_app/bill_payment.dart';
import 'lottery_info.dart';

class SeeTicketScreen extends StatefulWidget {
  const SeeTicketScreen({Key? key}) : super(key: key);

  @override
  State<SeeTicketScreen> createState() => _SeeTicketScreenState();
}

class _SeeTicketScreenState extends State<SeeTicketScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/background.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 95, 0, 0),
                child: Row(
                  children: [
                    InkWell(
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () => Navigator.pushNamed(context, '/home'),
                    )
                  ],
                ),
              ),
              const Positioned(
                top: 95,
                left: 65,
                child: Text(
                  "Худалдан авсан сугалаа харах",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const Positioned(
                top: 96,
                right: 24,
                child: Icon(
                  Icons.more_horiz,
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
                      width: 420,
                      height: 127,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(top: 220,
                  left: 70,
                  child: Text("Таны авсан сугалаанууд",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                  )
              )
            ],
          ),
          buildTicketList()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon( Icons.home_filled,
                size: 30,
              ),
              onPressed: () => Navigator.pushNamed(context, "/home"),
            ),
            IconButton(
                icon: const Icon(Icons.local_activity_outlined,
                    size: 30,
                    color: Color(0xffF58742)),
                onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.wallet_outlined,
                  size: 30),
              onPressed: () {
                Navigator.pushNamed(context, "/wallet");
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTicketList() {
  if (randomTicketNumbers.isEmpty) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    itemCount: randomTicketNumbers.length,
    itemBuilder: (context, index) {
      int buyedTicket = randomTicketNumbers[index];
      return ListTile(
        title: Text(
          'Сугалааны дугаар: $buyedTicket',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(lotteryName), // Replace with actual name if available
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffF0F6F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Image.asset(image))),
      );
    },
  );
}