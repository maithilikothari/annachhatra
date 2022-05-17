import 'package:flutter/material.dart';

class foodItems extends StatelessWidget {
  const foodItems({
    Key key,
    this.name,
    this.quantity,
  }) : super(key: key);
  final String name;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          SizedBox(
            width: 40,
          ),
          Text(
            'x' + quantity,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
