import 'package:flutter/material.dart';
import 'package:tea_app/screens/category/china_tab.dart';
import 'package:tea_app/screens/category/india_tab.dart';
import 'package:tea_app/screens/category/popular_tab.dart';
import 'package:tea_app/screens/category/sriLanka_tab.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TabBarView(
        children: <Widget>[PopularTab(), ChinaTab(), IndiaTab(), SriLankaTab()],
        controller: controllerInCategory,
      ),
      appBar: TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        controller: controllerInCategory,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black,
        tabs: <Tab>[
          Tab(
            text: 'POPULAR',
          ),
          Tab(
            text: 'CHINA',
          ),
          Tab(
            text: 'INDIA',
          ),
          Tab(
            text: 'SRI LANKA',
          )
        ],
      ),
    );
  }
}
