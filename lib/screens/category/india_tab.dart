import 'package:flutter/material.dart';

class IndiaTab extends StatefulWidget {
  @override
  _IndiaTabState createState() => _IndiaTabState();
}

class _IndiaTabState extends State<IndiaTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print("UPDATE from swipe to refresh - INDIA");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
          children: <Widget>[
            Center(child: Text('INDIA')),
          ],
        ),
      ),
    );
  }
}
