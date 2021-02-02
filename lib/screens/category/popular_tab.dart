import 'package:flutter/material.dart';
import 'package:tea_app/models/tea_model.dart';
import 'package:tea_app/providers/favorite_provider.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:provider/provider.dart';

import '../details.dart';

class PopularTab extends StatefulWidget {
  final String countryName;

  const PopularTab({
    Key key,
    this.countryName,
  }) : super(key: key);

  @override
  _PopularTabState createState() => _PopularTabState();
}

class _PopularTabState extends State<PopularTab> {
  List<TeaModel> teas = [];
  @override
  void initState() {
    initList();
    super.initState();
  }

  Future<void> initList([forceDownload = false]) async {
    teas = await context
        .read<TeaProvider>()
        .getListOfTeasByCountryName(widget.countryName, forceDownload);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await initList(true);
        print("UPDATE from swipe to refresh - POPULAR");
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
                      print('tapped on card');
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
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(teas[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ),
                              ),
                              Consumer<FavoriteProvider>(
                                builder: (context, favorite, child) {
                                  int indexOf = favorite.favorites.indexWhere(
                                      (element) =>
                                          element.name == teas[index].name);
                                  if (indexOf == -1) {
                                    return IconButton(
                                      icon: Icon(Icons.favorite,
                                          color: Colors.grey[400]),
                                      onPressed: () async {
                                        TeaModel obj = TeaModel(
                                          name: teas[index].name,
                                          price: teas[index].price,
                                          imgURL: teas[index].imgURL,
                                          description: teas[index].description,
                                          originCountry:
                                              teas[index].originCountry,
                                          brewTemp: teas[index].brewTemp,
                                          brewTime: teas[index].brewTime,
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
                                '\$ ${teas[index].price.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Consumer<FavoriteProvider>(
                                builder: (context, favorite, child) {
                                  return InkWell(
                                    onTap: () {
                                      print("ADDED TO CART");
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[400]),
                                      width: 30,
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
    );
  }
}
