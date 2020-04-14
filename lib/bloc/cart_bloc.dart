import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import '../item_bloc.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent, List<Item>> {
  List<Item> items = [];

  @override
  List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* {
    switch (event.type) {
      case CartEventType.add:
        items.add(event.item);
        break;
      case CartEventType.remove:
        items.remove(event.item);
        break;
    }
    yield items;
  }
}
