import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/models/tea_model.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:tea_app/screens/cart_screen.dart';
import 'package:tea_app/screens/details.dart';

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
      padding: const EdgeInsets.all(15),
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
                      if (Provider.of<CartProvider>(context, listen: true)
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
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF1F1F1),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 5),
                  child: TextField(
                    onSubmitted: (String input) async {
                      await Provider.of<TeaProvider>(context, listen: false)
                          .getTeaByName(input);

                      TeaModel obj =
                          Provider.of<TeaProvider>(context, listen: false)
                              .specificTea;

                      if (obj != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    name: obj.name,
                                    description: obj.description,
                                    imageUrl: obj.imgURL,
                                    price: obj.price,
                                  )),
                        );
                        clearTextInput();
                      } else {
                        return Fluttertoast.showToast(
                            msg: "Sprawdz pisownie i spróbuj ponownie",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      Provider.of<TeaProvider>(context, listen: false)
                          .specificTea = null;
                    },
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
