//import 'package:http/http.dart' as http;

import 'package:shelf/shelf.dart';

abstract class Repository<T> {
	final List<T> _items = [];

	Future<void> add(T item) async => _items.add(item);

	Future<List<T>> getAll() async => _items;
	
  Future<void> update(T item, T newItem) async {
		var index = _items.indexWhere((element) => element == item);
    if(index != -1){
		  _items[index] = newItem;
    }
	}

	Future<void> delete(T item) async => _items.remove(item);
}