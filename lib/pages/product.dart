import 'package:flutter/material.dart';
import 'package:foodkart/pages/home.dart';

class ProductPage extends StatefulWidget {
  final pid;
  final polist;
  const ProductPage({super.key, required this.pid, required this.polist});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var pid;
  var qty = 0;
  var buttonaddcart = "Add to Cart";
  var polist;

  @override
  void initState() {
    pid = widget.pid;
    if (widget.polist == null) {
      polist = {};
    } else {
      polist = widget.polist;
    }

    print(pid);
    print(polist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductPage!"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
            width: 20,
          ),
          Container(
            //width: 200,
            height: 300,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: Card(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${pid['name']}  ",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Image.network(height: 100, width: 100, "${pid['img']}"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(buttonaddcart),
                      onPressed: () {
                        if (qty >= 2) {
                          setState(() {
                            buttonaddcart = "Out of Stock";
                          });

                          print("stock full");
                        } else {
                          setState(() {
                            qty++;
                            print(qty);
                          });
                        }
                      },
                    ),
                  ),
                  Text("Quantity Added: $qty",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 5, 70, 5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 50, 15, 110)),
                        onPressed: () {
                          if (qty == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Add quantity to place order")));
                          } else {
                            //polist.putIfAbsent(pid['name'], () => qty);
                            polist["${pid['name']}"] = [
                              qty,
                              pid['price'],
                              pid['img']
                            ];
                            print("${pid['name']}");
                            print(polist);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(polist: polist)));
                          }
                        },
                        child: const Text(
                          "Confirm Order Quantity",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
