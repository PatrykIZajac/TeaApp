import 'package:flutter/material.dart';

class PopularTab extends StatefulWidget {
  @override
  _PopularTabState createState() => _PopularTabState();
}

class _PopularTabState extends State<PopularTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print("UPDATE from swipe to refresh - POPULAR");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
          children: <Widget>[
            Center(child: Text('POPULAR')),
          ],
        ),
      ),
    );
  }
}
