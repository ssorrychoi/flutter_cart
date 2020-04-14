import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/item_bloc.dart';
import 'package:flutter_cart/my_cart.dart';

import 'bloc/cart_bloc.dart';

/// Catalog
class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MyCart()));
            },
          )
        ],
      ),
      body: BlocBuilder<CartBloc, List<Item>>(
        bloc: _cartBloc,
        builder: (BuildContext context, List state) {
          return Center(
            child: ListView(
              children: _itemList
                  .map((item) => _buildItem(item, state, _cartBloc))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(Item todo, List state, CartBloc bloc) {
    final isChecked = state.contains(todo);

    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(fontSize: 31.0),
        ),
        subtitle: Text('${todo.price}'),
        trailing: IconButton(
          icon: isChecked
              ? Icon(
                  Icons.check,
                  color: Colors.redAccent,
                )
              : Icon(
                  Icons.check,
                ),
          onPressed: () {
            setState(() {
              if (isChecked) {
                bloc.add(CartEvent(CartEventType.remove, todo));
              } else {
                bloc.add(CartEvent(CartEventType.add, todo));
              }
            });
          },
        ),
      ),
    );
  }
}
