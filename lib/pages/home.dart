import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodkart/main.dart';
import 'package:foodkart/pages/kart.dart';
import 'package:foodkart/pages/product.dart';

class HomePage extends StatefulWidget {
  final polist;
  const HomePage({super.key, required this.polist});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  var polist;
  var pricelist;

  @override
  void initState() {
    if (widget.polist == null) {
      polist = {};
    } else {
      polist = widget.polist;
    }
    super.initState();
  }

  Widget Hbackcard(documentSnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // for (int i = 0; i < 5; i++)
        GestureDetector(
          onTap: () {
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text("${documentSnapshot['name']}")));
          },
          child: Card(
            color: Colors.white,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${documentSnapshot['name']} ",
                  style: const TextStyle(color: Colors.black),
                ),
                Expanded(
                  child: Image.network(
                      fit: BoxFit.fill,
                      //height: 100,
                      width: 100,
                      "${documentSnapshot['img']}"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget Vbackcard(documentSnapshot, polist) {
    //polist = widget.polist;
    var pid = documentSnapshot;

    //print(documentSnapshot['name']);
    print(polist);
    return Column(
      children: [
        //for (int j = 1; j < 10; j++)
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductPage(pid: pid, polist: polist)));

            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     content: Text("Product Name: ${documentSnapshot['name']}")));
          },
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                        height: 100, width: 100, "${documentSnapshot['img']}"),
                    Text(
                      "${documentSnapshot['name']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Price: ${documentSnapshot['price']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Qty Left= ${documentSnapshot['stock']}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FoodKart App!"),
          actions: [
            IconButton(
              icon: polist == null
                  ? const Icon(Icons.settings)
                  : const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KartPage(polist: polist)));
              },
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 84, 74, 74),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 100, 10, 50),
                  child: Text("User: ${user.email!}")),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             LoginPage()));

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Signout"))),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    KartPage(polist: polist)));
                      },
                      child: const Text("Go to cart!"))),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: products.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Welcome: ${user.displayName}"),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Food Items available"),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Hbackcard(documentSnapshot);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Vbackcard(documentSnapshot, polist);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else {
                return const Text("empty");
              }
            }));
  }
}

/*testing*/
                        // Card(
                        //   margin: EdgeInsets.all(10),
                        //   child: ListTile(
                        //     title:
                        //         Text("product name : ${documentSnapshot['name']}"),
                        //     //Text("data ${documentSnapshot['name']}"),
                        //     //subtitle: Text("Price: ${documentSnapshot['price']}"),
                        //     subtitle:
                        //         Text("${documentSnapshot['price'].toString()}"),
                        //   ),
                        // );
                          // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("HomePage")),
  //     drawer: Drawer(
  //       backgroundColor: const Color.fromARGB(255, 84, 74, 74),
  //       child: Column(
  //         children: [
  //           Container(
  //               margin: EdgeInsets.fromLTRB(10, 100, 10, 50),
  //               child: Text("User: ${user.email!}")),
  //           Container(
  //               margin: EdgeInsets.fromLTRB(10, 10, 10, 100),
  //               child: ElevatedButton(
  //                   onPressed: () {
  //                     FirebaseAuth.instance.signOut();
  //                   },
  //                   child: Text("Signout"))),
  //         ],
  //       ),
  //     ),
  //     body: Column(
  //       // mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           margin: EdgeInsets.all(5),
  //           color: const Color.fromARGB(255, 45, 45, 45),
  //           child: Text("Current User: ${user.email}"),
  //         ),

  //         //test
  //         ElevatedButton(
  //             onPressed: () {
  //               readProducts();
  //             },
  //             child: Text("read products")),

  //         //test

  //         //rowItem
  //         Container(
  //           margin: EdgeInsets.all(5),
  //           color: const Color.fromARGB(255, 45, 45, 45),
  //           child: SingleChildScrollView(
  //               scrollDirection: Axis.horizontal, child: Hbackcard()),
  //         ),
  //         Expanded(
  //           child: Container(
  //             //height: MediaQuery.of(context).size.height,
  //             decoration:
  //                 BoxDecoration(color: const Color.fromARGB(255, 57, 57, 57)),
  //             margin: EdgeInsets.all(5),
  //             child: SingleChildScrollView(child: Vbackcard()),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  /*testing*/