import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/bloc/cart_bloc.dart';
import 'package:flutter_cart/item_bloc.dart';
import 'package:flutter_cart/main.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder(
        stream: cartBloc.cartList,
        builder: (context, snapshot) {
          var sum = 0;
          if (snapshot.data.length > 0) {
            sum = snapshot.data
                .map((item) => item.price)
                .reduce((acc, e) => acc + e);
          }
          return Center(
            child: Text(
              'SUM : $sum',
              style: TextStyle(fontSize: 30.0),
            ),
          );
        },
      ),
    );
  }
}
