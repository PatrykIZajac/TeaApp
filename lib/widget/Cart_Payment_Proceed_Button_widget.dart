import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/local_storage/user_preferences.dart';
import 'package:tea_app/providers/cart_provider.dart';

class CartPaymentProceedButton extends StatefulWidget {
  @override
  _CartPaymentProceedButtonState createState() =>
      _CartPaymentProceedButtonState();
}

class _CartPaymentProceedButtonState extends State<CartPaymentProceedButton> {
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
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () async {
          await Provider.of<CartProvider>(context, listen: false)
              .deleteAllItems();
          setState(() {});
          Navigator.pop(context);

          showDialog(
              context: context,
              builder: (context) {
                Future.delayed(Duration(milliseconds: 400), () {
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
              child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${delegate.ContinuePaymentText} (' +
                    getTotalCost().toString() +
                    ')',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
