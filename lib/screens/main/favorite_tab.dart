import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/models/cart_model.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/providers/favorite_provider.dart';
import '../details.dart';

class FavoriteTab extends StatefulWidget {
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  void initState() {
    print(
        Provider.of<FavoriteProvider>(context, listen: false).favorites.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    var teas = Provider.of<FavoriteProvider>(context, listen: false).favorites;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          '${delegate.FavoriteText}',
          style: TextStyle(color: Colors.white, fontSize: 25),
        )),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("UPDATE from swipe to refresh - FAVORITE");
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: GridView.builder(
              itemCount: teas.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color(0xFFF1F1F1),
                    child: InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      onTap: () {
                        // print('tapped on card');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    name: teas[index].name,
                                    description: teas[index].description,
                                    imageUrl: teas[index].imgURL,
                                    price: teas[index].price,
                                  )),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Text(teas[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Provider.of<FavoriteProvider>(context,
                                            listen: false)
                                        .deleteFromFavorite(teas[index]);
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Image.network(
                                teas[index].imgURL,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  teas[index]
                                      .getCurrency(teas[index].price)
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Consumer<FavoriteProvider>(
                                  builder: (context, favorite, child) {
                                    return InkWell(
                                      onTap: () async {
                                        CartModel obj = CartModel(
                                          imgURL: teas[index].imgURL,
                                          price: teas[index].price,
                                          name: teas[index].name,
                                          count: 1,
                                        );

                                        var status = Provider.of<CartProvider>(
                                                context,
                                                listen: false)
                                            .cart
                                            .where((element) =>
                                                element.name ==
                                                teas[index].name);

                                        if (status.isNotEmpty) {
                                          await Provider.of<CartProvider>(
                                                  context,
                                                  listen: false)
                                              .updateById(obj, 1);
                                        } else {
                                          await Provider.of<CartProvider>(
                                                  context,
                                                  listen: false)
                                              .addToCart(obj);
                                        }
                                        String name = teas[index].name;
                                        Fluttertoast.showToast(
                                            msg: "Added $name to cart!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      child: Consumer<CartProvider>(
                                        builder: (context, cart, child) {
                                          int indexOf = cart.cart.indexWhere(
                                              (element) =>
                                                  element.name ==
                                                  teas[index].name);
                                          if (indexOf == -1) {
                                            return Container(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey[400]),
                                              width: 30,
                                            );
                                          } else {
                                            return Container(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              width: 30,
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
