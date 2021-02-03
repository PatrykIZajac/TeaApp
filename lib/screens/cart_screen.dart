import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String getTotalCost() {
    double total = 0.00;
    for (int i = 0;
        i < Provider.of<CartProvider>(context, listen: false).cart.length;
        i++) {
      total += Provider.of<CartProvider>(context, listen: false).cart[i].price *
          Provider.of<CartProvider>(context, listen: false).cart[i].count;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CartProvider>(builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Shopping cart',
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 10.00, bottom: 10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 1.20,
                    child: ListView.builder(
                        itemCount: cart.cart.length,
                        itemBuilder: (context, index) {
                          final item = cart.cart[index];
                          return Dismissible(
                            key: Key(item.name),
                            onDismissed: (direction) {
                              print("Dismised" + item.name);
                              Provider.of<CartProvider>(context, listen: false)
                                  .deleteFromCart(item);
                              setState(() {});
                              if (Provider.of<CartProvider>(context,
                                          listen: false)
                                      .cart
                                      .length ==
                                  0) {
                                Navigator.pop(context);
                              }
                            },
                            background: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: Icon(
                                  Icons.cancel,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFFF1F1F1)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Image.network(
                                                      item.imgURL),
                                                ),
                                                Text(
                                                  item.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    item.count.toString() +
                                                        ' qty.',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () async {
                        await Provider.of<CartProvider>(context, listen: false)
                            .deleteAllItems();
                        setState(() {});
                        Navigator.pop(context);
                        successDialog(
                          context,
                          "Success message",
                          negativeAction: () {},
                          positiveAction: () {},
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).primaryColor,
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Center(
                            child: Text(
                          'Continue paymant (' +
                              getTotalCost().toString() +
                              ')',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
