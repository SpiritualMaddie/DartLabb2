import 'dart:convert';
import 'dart:io';
import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

class PersonRepository implements RepositoryInterface<Person>{

  static final PersonRepository _instance = PersonRepository._internal();
  PersonRepository._internal();
  factory PersonRepository() => _instance;

  final uri = Uri.parse("http://localhost:8080/persons");
  

  @override
  Future<List<Person>> getAll() async {
    try {
      // Fetching from db
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List) {

          return json.map((person) => Person.fromJson(person)).toList();
        } else {
          throw FormatException("Förväntades en List av Persons men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda personer. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error i hämtningen av personer: $error');
      rethrow;
    }
  }
  
  @override
  Future<Person?> create(Person item) async {
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Person.fromJson(json);
    } else {
      throw Exception('Misslyckades att skapa personen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i skapandet av personen: $error');
    rethrow;
  }
  }
  
  @override
  Future<Person?> delete(int id) async {
  try {
    final uriWithId = Uri.parse('$uri/$id');

    final response = await http.delete(
      uriWithId,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Person.fromJson(json);
      
    } else {
      throw Exception('Misslyckades att ta bort personen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i borttagning av personen: $error');
    rethrow;
  }
  }
  
  @override
  Future<Person?> getById(int id) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Fetching from db
      final response = await http.get(uriWithId, headers: {'Content-Type': 'application/json'});

      // Handle 404 Not Found
      if(response.statusCode == 404){
        stdout.writeln("Personen hittades inte, vänligen försök igen.");
        return null;
      }
      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Check the response body is not null or unexpected
        if (json != null && json is Map<String, dynamic>) {

          return Person.fromJson(json);
        }else {
          throw FormatException("Förväntade sig en person men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda person. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error att hämta person: $error');
      rethrow;
    }
  }
  
  @override
  Future<Person?> update(int id, Person person) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Check for successful response
      final response = await http.put(
        uriWithId, 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(person.toJson()));

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Person.fromJson(json);

      } else {
        throw Exception('Misslyckades att uppdatera personen. Statuskod: ${response.statusCode}');

      }
    } catch (error) {
      print('Error i uppdatering av personen: $error');
      rethrow;
    }
  }
}