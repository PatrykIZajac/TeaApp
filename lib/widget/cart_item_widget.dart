import 'package:flutter/material.dart';
import 'package:tea_app/generated/l10n.dart';
import 'package:tea_app/models/cart_model.dart';

class CartItemWidget extends StatefulWidget {
  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
  final CartModel item;
  const CartItemWidget({Key key, this.item}) : super(key: key);
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFF1F1F1)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.network(widget.item.imgURL),
                ),
                Text(
                  widget.item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Text(
                    '${widget.item.count.toString()} ${delegate.QuantityCartItem}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
