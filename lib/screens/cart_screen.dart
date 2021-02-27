import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/models/cart_model.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/widget/Cart_Payment_Proceed_Button_widget.dart';
import 'package:tea_app/widget/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _showMyDialog(int amount, String teaName, CartModel cartModel,
      String amountText, String acceptText, String cancelText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Center(child: Text('$amountText $teaName')),
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
                              acceptText,
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
                              cancelText,
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

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return SafeArea(
      child: Container(
        child: Consumer<CartProvider>(builder: (context, cart, child) {
          return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  '${delegate.ShoppingCartText}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10.00, bottom: 10),
                child: Scrollbar(
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
                                    // print("Dismised" + item.name);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              // print("Tapped item");
                                              _showMyDialog(
                                                item.count.toInt(),
                                                item.name,
                                                item,
                                                delegate
                                                    .AmountInAlertDialogText,
                                                delegate
                                                    .AcceptButtonInAlertDialogText,
                                                delegate
                                                    .CancelButtonInAlertDialogText,
                                              );
                                            },
                                            child: CartItemWidget(item: item),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        CartPaymentProceedButton(),
                      ],
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
