import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/bloc/cart_bloc.dart';
import 'package:flutter_cart/item_bloc.dart';

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
      body: BlocBuilder<CartBloc, List<Item>>(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (BuildContext context, List state) {
          var sum = 0;
          if (state.length > 0) {
            sum = state.map((item) => item.price).reduce((acc, e) => acc + e);
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
