import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/local_storage/user_preferences.dart';
import 'package:tea_app/models/cart_model.dart';
import 'package:tea_app/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _showMyDialog(int amount, String teaName, CartModel cartModel,
      String AmountText, String AcceptText, String CancelText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Center(child: Text('${AmountText} ${teaName}')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            if (amount > 1) {
                              amount -= 1;
                              setState(() {});
                            }
                          },
                          child: Container(
                            child: Icon(Icons.remove),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Text(
                          '${amount.toString()}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            if (amount < 15) {
                              amount += 1;
                              setState(() {});
                            }
                          },
                          child: Container(
                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: Text(
                              "${AcceptText}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () async {
                            if (amount == cartModel.count) {
                              Navigator.of(context).pop();
                            } else {
                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .changeCountOfItem(cartModel, amount);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        InkWell(
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent,
                            ),
                            child: Center(
                                child: Text(
                              "${CancelText}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  String getTotalCost() {
    double total = 0.00;
    for (int i = 0;
        i < Provider.of<CartProvider>(context, listen: false).cart.length;
        i++) {
      total += Provider.of<CartProvider>(context, listen: false).cart[i].price *
          Provider.of<CartProvider>(context, listen: false).cart[i].count;
    }
    if (UserPreferences().getCurrency() == UserPreferences.dolar) {
      double result = total;
      return "${result.toStringAsFixed(2)} \u{0024}";
    }
    if (UserPreferences().getCurrency() == UserPreferences.zloty) {
      double result = total * 3.74;
      return "${result.toStringAsFixed(2)} PLN";
    }
    if (UserPreferences().getCurrency() == UserPreferences.pound) {
      double result = total * 0.72;
      return "${result.toStringAsFixed(2)} \u{20A4}";
    }
    if (UserPreferences().getCurrency() == UserPreferences.euro) {
      double result = total * 0.83;
      return "${result.toStringAsFixed(2)} \u{20AC}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Container(
        child: Consumer<CartProvider>(builder: (context, cart, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${delegate.ShoppingCartText}',
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10.00, bottom: 10),
                child: SingleChildScrollView(
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
                                  Provider.of<CartProvider>(context,
                                          listen: false)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: InkWell(
                                          onTap: () {
                                            print("Tapped item");
                                            _showMyDialog(
                                              item.count.toInt(),
                                              item.name,
                                              item,
                                              delegate.AmountInAlertDialogText,
                                              delegate
                                                  .AcceptButtonInAlertDialogText,
                                              delegate
                                                  .CancelButtonInAlertDialogText,
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFFF1F1F1)),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${item.count.toString()} ${delegate.QuantityCartItem}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
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
                            await Provider.of<CartProvider>(context,
                                    listen: false)
                                .deleteAllItems();
                            setState(() {});
                            Navigator.pop(context);

                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(milliseconds: 200),
                                      () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return Padding(
                                    padding: const EdgeInsets.all(100),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.done,
                                        size: 150,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                });
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
                              '${delegate.ContinuePaymentText} (' +
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
                ),
              ));
        }),
      ),
    );
  }
}
