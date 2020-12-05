import 'package:flutter/material.dart';
import 'file:///G:/TeaApp/tea_app/lib/screens/category/category_host.dart';
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
  }
}
