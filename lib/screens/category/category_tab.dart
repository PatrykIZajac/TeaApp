import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/models/tea_model.dart';
import 'package:tea_app/providers/tea_provider.dart';
import 'package:tea_app/widget/card_widget.dart';

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
        print(widget.countryName);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: GridView.builder(
            itemCount: teas.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return CardWidget(teas: teas, index: index);
            }),
      ),
    );
  }
}
