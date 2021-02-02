import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/screens/cart_screen.dart';

class HeaderWidget extends StatefulWidget with PreferredSizeWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(200);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  @override
  void dispose() {
    nameHolder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${delegate.WelcomeText}',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 36.0,
                      ),
                      if (Provider.of<CartProvider>(context, listen: false)
                              .cart
                              .length >
                          0)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Color(0xFF11bb6c),
                            foregroundColor: Colors.white,
                            child: Text(
                              Provider.of<CartProvider>(context, listen: true)
                                  .getCountOfCart()
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    if (Provider.of<CartProvider>(context, listen: false)
                        .cart
                        .isNotEmpty)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                  },
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '${delegate.ShopNameText}',
                style: TextStyle(
                    fontSize: 45,
                    color: Color(0xFF11bb6c),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF1F1F1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    controller: nameHolder,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: '${delegate.SearchText}',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
