import 'dart:convert';

import 'package:shared/models/person.dart';
import 'package:http/http.dart' as http;
import 'repository.dart';

class PersonRepository extends Repository<Person>{

  static final PersonRepository _instance = PersonRepository._internal();

  PersonRepository._internal();

  factory PersonRepository() => _instance;

  final uri = Uri.parse("http://localhost:8080/persons");
  

    @override
  Future<List<Person>> getAll() async {
    try {
      // Check for successful response
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List) {

          return json.map((person) => Person.fromJson(person)).toList();
        } else {
          throw FormatException("Expected a List of Persons but got ${json.runtimeType}");
        }
      } else {
        throw Exception('Failed to load persons. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching persons: $error');
      rethrow;
    }
  }
// @override
//   Future<List<Person>> getAll() async {

//     final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
//     print(response.body);
//     Future.delayed(Duration(seconds: 5));

//     final json = jsonDecode(response.body);

//     return (json as List).map((person) => Person.fromJson(person)).toList();
//   }

}