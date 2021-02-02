import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/providers/favorite_provider.dart';

import '../details.dart';

class FavoriteTab extends StatefulWidget {
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Favorites',
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
              itemCount: Provider.of<FavoriteProvider>(context, listen: true)
                  .favorites
                  .length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                                  name: Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .favorites[index]
                                      .name,
                                  description: Provider.of<FavoriteProvider>(
                                          context,
                                          listen: false)
                                      .favorites[index]
                                      .description,
                                  imageUrl: Provider.of<FavoriteProvider>(
                                          context,
                                          listen: false)
                                      .favorites[index]
                                      .imgURL,
                                  price: Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .favorites[index]
                                      .price,
                                )),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Image.network(
                              Provider.of<FavoriteProvider>(context,
                                      listen: false)
                                  .favorites[index]
                                  .imgURL,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                              Provider.of<FavoriteProvider>(context,
                                      listen: false)
                                  .favorites[index]
                                  .name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$ ${Provider.of<FavoriteProvider>(context, listen: false).favorites[index].price.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<FavoriteProvider>(context,
                                          listen: false)
                                      .deleteById(Provider.of<FavoriteProvider>(
                                              context,
                                              listen: false)
                                          .favorites[index]
                                          .id);
                                  setState(() {});
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[350]),
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
