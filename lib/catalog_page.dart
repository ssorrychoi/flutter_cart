import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/item_bloc.dart';
import 'package:flutter_cart/main.dart';
import 'package:flutter_cart/my_cart.dart';

import 'bloc/cart_bloc.dart';

/// Catalog
class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
          stream: cartBloc.cartList,
          builder: (context, snapshot) {
            return ListView(
              children: cartBloc.itemList
                  .map((item) => _buildItem(item, snapshot.data))
                  .toList(),
            );
          },
        ));
  }

  Widget _buildItem(Item todo, List<Item> state) {
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
            if (isChecked) {
              cartBloc.add(CartEvent(CartEventType.remove, todo));
            } else {
              cartBloc.add(CartEvent(CartEventType.add, todo));
            }
          },
        ),
      ),
    );
  }
}
