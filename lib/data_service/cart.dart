import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guitar_app/data_service/guitar_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:guitar_app/signin.dart';
import 'package:guitar_app/data_service/cart.dart';
import 'package:guitar_app/addtocart.dart';
import 'package:http/http.dart' as http;

class CartItem extends ChangeNotifier{
  final int productId;
  final String productName;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1,
  });
}


