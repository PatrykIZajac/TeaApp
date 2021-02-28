import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/models/cart_model.dart';
import 'package:tea_app/models/tea_model.dart';
import 'package:tea_app/providers/cart_provider.dart';
import 'package:tea_app/providers/favorite_provider.dart';
import 'package:tea_app/screens/details.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();

  final List<TeaModel> teas;
  final int index;

  const CardWidget({
    Key key,
    this.teas,
    this.index,
  }) : super(key: key);
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
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
                        name: widget.teas[widget.index].name,
                        description: widget.teas[widget.index].description,
                        imageUrl: widget.teas[widget.index].imgURL,
                        price: widget.teas[widget.index].price,
                      )),
            );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: Text(widget.teas[widget.index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    Consumer<FavoriteProvider>(
                      builder: (context, favorite, child) {
                        int indexOf = favorite.favorites.indexWhere((element) =>
                            element.name == widget.teas[widget.index].name);
                        if (indexOf == -1) {
                          return IconButton(
                            icon: Icon(Icons.favorite, color: Colors.grey[400]),
                            onPressed: () async {
                              TeaModel obj = TeaModel(
                                name: widget.teas[widget.index].name,
                                price: widget.teas[widget.index].price,
                                imgURL: widget.teas[widget.index].imgURL,
                                description:
                                    widget.teas[widget.index].description,
                                originCountry:
                                    widget.teas[widget.index].originCountry,
                                brewTemp: widget.teas[widget.index].brewTemp,
                                brewTime: widget.teas[widget.index].brewTime,
                              );
                              Provider.of<FavoriteProvider>(context,
                                      listen: false)
                                  .addToFavorite(obj);
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Image.network(
                    widget.teas[widget.index].imgURL,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          widget.teas[widget.index]
                              .getCurrency(widget.teas[widget.index].price)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, favorite, child) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () async {
                            CartModel obj = CartModel(
                              imgURL: widget.teas[widget.index].imgURL,
                              price: widget.teas[widget.index].price,
                              name: widget.teas[widget.index].name,
                              count: 1,
                            );
                            var status = Provider.of<CartProvider>(context,
                                    listen: false)
                                .cart
                                .where((element) =>
                                    element.name ==
                                    widget.teas[widget.index].name);

                            if (status.isNotEmpty) {
                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .updateById(obj, 1);
                            } else {
                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .addToCart(obj);
                            }
                            String name = widget.teas[widget.index].name;
                            Fluttertoast.showToast(
                                msg: "Added $name to cart!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Consumer<CartProvider>(
                            builder: (context, cart, child) {
                              int indexOf = cart.cart.indexWhere((element) =>
                                  element.name ==
                                  widget.teas[widget.index].name);
                              if (indexOf == -1) {
                                return Container(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5),
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
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor),
                                  width: 30,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
