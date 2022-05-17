import 'package:flutter/material.dart';

import 'foodItems.dart';

typedef OnDeleteCallBack = void Function(Map index);

class AddDishListTab extends StatelessWidget {
  const AddDishListTab({
    Key key,
    @required this.dishName,
    @required this.quantity,
    @required this.index,
    @required this.onDelete,
  }) : super(key: key);
  final String dishName;
  final String quantity;
  final Map index;
  final OnDeleteCallBack onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              onDelete(index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
        foodItems(
          name: dishName,
          quantity: quantity,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
