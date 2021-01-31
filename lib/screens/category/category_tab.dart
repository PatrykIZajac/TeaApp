import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/models/tea_model.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:tea_app/screens/details.dart';

class CategoryTab extends StatefulWidget {
  final String countryName;

  const CategoryTab({
    Key key,
    this.countryName,
  }) : super(key: key);

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with TickerProviderStateMixin {
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
        print("UPDATE from swipe to refresh - CHINA");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: GridView.builder(
            itemCount: teas.length,
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
                                name: teas[index].name,
                                description: teas[index].description,
                                imageUrl: teas[index].imgURL,
                                price: teas[index].price,
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Image.network(
                            teas[index].imgURL,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(teas[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${teas[index].price.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            InkWell(
                              onTap: () {
                                print("Tapped add button");
                              },
                              child: Container(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey[400]),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[400]),
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
    );
  }
}
