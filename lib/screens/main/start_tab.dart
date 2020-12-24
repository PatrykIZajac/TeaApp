import 'package:flutter/material.dart';
import 'package:tea_app/screens/category/category_host.dart';
import 'package:tea_app/widget/header_widget.dart';

class StartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CategoryHost();
    return Scaffold(
      appBar: HeaderWidget(),
      body: CategoryHost(),
    );
  }
}
