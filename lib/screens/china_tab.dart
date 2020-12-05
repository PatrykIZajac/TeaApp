import 'package:flutter/material.dart';

class ChinaTab extends StatefulWidget {
  @override
  _ChinaTabState createState() => _ChinaTabState();
}

class _ChinaTabState extends State<ChinaTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print("UPDATE from swipe to refresh - CHINA");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
          children: <Widget>[
            Center(child: Text('China')),
          ],
        ),
      ),
    );
  }
}
