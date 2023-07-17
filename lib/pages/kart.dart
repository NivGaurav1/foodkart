import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:foodkart/pages/done.dart';
import 'package:foodkart/pages/home.dart';

class KartPage extends StatefulWidget {
  final polist;
  const KartPage({super.key, required this.polist});

  @override
  State<KartPage> createState() => _KartPageState();
}

class _KartPageState extends State<KartPage> {
  final user = FirebaseAuth.instance.currentUser!;
  var polist;

  @override
  void initState() {
    if (widget.polist == null) {
      polist = {};
    } else {
      polist = widget.polist;
      print(polist);
    }
    super.initState();
    print(polist);
    totalamount(polist);
  }

  totalamount(polist) {
    num total = 0;

    polist.forEach((k, v) {
      total = (total) + (v[0] * v[1]);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    print(polist);
    return Scaffold(
      appBar: AppBar(title: const Text("KartPage")),
      body: Column(
        children: [
          Text("Name :${user.displayName}"),
          Text("${user.email}"),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: polist.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = polist.keys.elementAt(index);
                  return Card(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                            height: 100, width: 100, "${polist['$key'][2]}"),
                        Text(
                          //"Name ${polist['name']}",
                          "$key",
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Qty = ${polist['$key'][0]}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "price = ${(polist['$key'][1]) * (polist['$key'][0])}  ",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Text(
            "Total Amount : ${totalamount(polist).toString()}",
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.black),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //color: Colors.white,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  if (polist.length == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("There is no item in the cart!")));
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const DonePage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 57, 17, 125),
                ),
                child: const Text(
                  "Order",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
