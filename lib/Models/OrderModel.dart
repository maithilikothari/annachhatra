import 'dart:html';

import 'package:flutter/foundation.dart';

class OrderModel {
  final String id;
  final List<Map> items;
  final bool isAvailable;
  final Location cordinates;
  final String allotedId;
  final String ownerId;

  OrderModel(
      {@required this.id,
      @required this.items,
      @required this.isAvailable,
      @required this.cordinates,
      @required this.allotedId,
      @required this.ownerId});
}
