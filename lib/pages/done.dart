import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodkart/pages/home.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          //Text("Thanks for using FoodKart! \n Enjoy your meal!"),
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("done pressed");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomePage(polist: {})));
              },
              child: Image.network(
                  //height: 100,
                  fit: BoxFit.fitHeight,
                  "https://cdn.dribbble.com/users/583807/screenshots/5187139/v5.gif"),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
