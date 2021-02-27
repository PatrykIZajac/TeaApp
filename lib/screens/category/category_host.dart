import 'package:flutter/material.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/screens/category/category_tab.dart';

class CategoryHost extends StatefulWidget {
  @override
  _CategoryHostState createState() => _CategoryHostState();
}

class _CategoryHostState extends State<CategoryHost>
    with TickerProviderStateMixin {
  TabController controllerInCategory;

  @override
  void initState() {
    super.initState();
    controllerInCategory =
        TabController(length: 4, vsync: this, initialIndex: 0);
    controllerInCategory.addListener(() {
      _handleTabSelection();
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    controllerInCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TabBarView(
        children: <Widget>[
          CategoryTab(countryName: 'popular'),
          CategoryTab(countryName: 'China'),
          CategoryTab(countryName: 'Brazil'),
          CategoryTab(countryName: 'Sri Lanka'),
        ],
        controller: controllerInCategory,
      ),
      appBar: TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        controller: controllerInCategory,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black,
        tabs: <Tab>[
          Tab(
            text: '${delegate.PopularText}',
          ),
          Tab(
            text: '${delegate.ChinaText}',
          ),
          Tab(
            text: '${delegate.IndiaText}',
          ),
          Tab(
            text: '${delegate.SriLankaText}',
          )
        ],
      ),
    );
  }
}
