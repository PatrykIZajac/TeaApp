import 'package:flutter/material.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
