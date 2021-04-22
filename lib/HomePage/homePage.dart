import 'package:flutter/material.dart';
import 'package:subscription/PaymentGateway/payment/check.dart';
import 'package:subscription/components/items.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Subscribtion Plans"),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(items[index]["name"]),
                    subtitle: Text("Rs." + items[index]["price"]),
                    trailing: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          "subscribe Now",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          double price = double.parse(items[index]["price"]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckRazor(
                                        price: price,
                                      )));
                        }),
                  ),
                ),
              );
            }));
  }
}
