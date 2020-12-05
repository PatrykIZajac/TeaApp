import 'package:flutter/material.dart';

class SriLankaTab extends StatefulWidget {
  @override
  _SriLankaTabState createState() => _SriLankaTabState();
}

class _SriLankaTabState extends State<SriLankaTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print("UPDATE from swipe to refresh - SRI LANKA");
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
          children: <Widget>[
            Center(child: Text('SRI LANKA')),
          ],
        ),
      ),
    );
  }
}
