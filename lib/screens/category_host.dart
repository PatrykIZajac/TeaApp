import 'package:flutter/material.dart';
import 'package:tea_app/screens/china_tab.dart';
import 'package:tea_app/screens/india_tab.dart';
import 'package:tea_app/screens/popular_tab.dart';
import 'package:tea_app/screens/sriLanka_tab.dart';

class CategoryHost extends StatefulWidget {
  @override
  _CategoryHostState createState() => _CategoryHostState();
}

class _CategoryHostState extends State<CategoryHost>
    with TickerProviderStateMixin {
  TabController controllerInFav;

  @override
  void initState() {
    super.initState();
    controllerInFav = TabController(length: 4, vsync: this, initialIndex: 0);
    controllerInFav.addListener(() {
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
        controller: controllerInFav,
      ),
      appBar: TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        controller: controllerInFav,
        tabs: <Tab>[
          Tab(
            text: 'Popular',
          ),
          Tab(
            text: 'China',
          ),
          Tab(
            text: 'India',
          ),
          Tab(
            text: 'Sri Lanka',
          )
        ],
      ),
    );
  }
}
