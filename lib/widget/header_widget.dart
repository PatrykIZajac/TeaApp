import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final nameHolder = TextEditingController();

  clearTextInput() {
    nameHolder.clear();
  }

  @override
  void dispose() {
    nameHolder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome to',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: null)
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Tea Shop',
              style: TextStyle(
                  fontSize: 45,
                  color: Color(0xFF11bb6c),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF1F1F1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  controller: nameHolder,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
