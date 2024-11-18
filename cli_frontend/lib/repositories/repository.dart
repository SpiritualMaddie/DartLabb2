import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Repository<T> {
	List<T> _items = [];

	Future<void> add(T item) async => _items.add(item);

  // Blueprint
	// Future<void> add(T item) async{
  //   final uri = Uri.parse("http://localhost:8080/items");
  //   await http.post(
  //     uri, 
  //     headers:{'Content-Type':'application/json'}, 
  //     body: jsonEncode({'description': item.description}));
  // }   

	Future<List<T>> getAll() async => _items;
	
  // Future<T> getById(int id) async{
  //   var item = _items.indexWhere((i) => i.id == id);
  //   return item;
  // }

	Future<void> update(T item, T newItem) async {
		var index = _items.indexWhere((element) => element == item);
		_items[index] = newItem;
	}

	Future<void> delete(T item) async => _items.remove(item);

  Map<String, dynamic> toJson() => {};
  Map<String, dynamic> fromJson() => {};


  //Example code
  // final json = jsonDecode(response.body);
  // return (json as List).map((item) => Item.fromJson(item).toList());
}