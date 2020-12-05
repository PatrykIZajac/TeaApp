import 'package:flutter/material.dart';
import 'package:tea_app/screens/category_host.dart';
import 'package:tea_app/widget/header_widget.dart';

class StartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            children: [
              HeaderWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(height: 300, child: CategoryHost()),
              ),
            ],
          ),
        ),
      ),
    );

    // return RefreshIndicator(
    //   onRefresh: () async {
    //     print("UPDATE from swipe to refresh");
    //   },
    //   child: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
    //       child: ListView(
    //         children: <Widget>[
    //           HeaderWidget(),
    //           Padding(
    //             padding: const EdgeInsets.only(top: 15.0),
    //             child: Container(height: 100, child: CategoryHost()),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
