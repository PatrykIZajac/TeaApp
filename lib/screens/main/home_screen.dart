import 'package:flutter/material.dart';
import 'package:tea_app/screens/main/favorite_tab.dart';
import 'package:tea_app/screens/main/settings_tab.dart';
import 'package:tea_app/screens/main/start_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  TabController controllerInMain;

  @override
  void initState() {
    super.initState();
    controllerInMain = TabController(length: 3, vsync: this, initialIndex: 1);
    controllerInMain.addListener(() {
      _handleTabSelection();
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    controllerInMain.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: TabBarView(
        children: <Widget>[
          FavoriteTab(),
          StartTab(),
          SettingsTab(),
        ],
        controller: controllerInMain,
      ),
      bottomNavigationBar: TabBar(
        controller: controllerInMain,
        indicatorColor: Theme.of(context).primaryColor,
        tabs: <Tab>[
          Tab(
            icon: Icon(
              Icons.favorite,
              color: Color(0xFF11bb6c),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.home,
              color: Color(0xFF11bb6c),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.settings,
              color: Color(0xFF11bb6c),
            ),
          )
        ],
      ),
    );
  }
}
