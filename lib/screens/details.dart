import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/models/cart_model.dart';
import 'package:tea_app/providers/cart_provider.dart';

class Details extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const Details(
      {Key key, this.name, this.description, this.imageUrl, this.price})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int counter = 1;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter != 1) {
        counter--;
      } else {
        return counter = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tea Shop'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              child: Image.network(widget.imageUrl),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color(0xFFF1F1F1),
            ),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            // color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        width: 100,
                        height: 30,
                        child: Center(
                          child: Text("\$ ${widget.price}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Text(widget.description),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print('-');
                            decrementCounter();
                            print("counter: $counter");
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
                          '$counter',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            print('+');
                            incrementCounter();
                            print("counter: $counter");
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
                    padding: const EdgeInsets.only(top: 25),
                    child: GestureDetector(
                      onTap: () async {
                        CartModel obj = CartModel(
                            name: widget.name,
                            price: widget.price,
                            imgURL: widget.imageUrl,
                            count: counter);

                        var status = Provider.of<CartProvider>(context,
                                listen: false)
                            .cart
                            .where((element) => element.name == widget.name);

                        if (status.isNotEmpty) {
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .updateById(obj, counter);
                          print("UPDATE");
                          Navigator.pop(context);
                        } else {
                          print("ADD");
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .addToCart(obj);
                          Navigator.pop(context);
                        }

                        // if (widget.name != null && counter > 0) {
                        //   Provider.of<CartProvider>(context, listen: false)
                        //       .addToCart(obj);
                        //   setState(() {});
                        //   Navigator.pop(context);
                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        width: 140,
                        height: 45,
                        child: Center(
                            child: Text(
                          'Buy',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
