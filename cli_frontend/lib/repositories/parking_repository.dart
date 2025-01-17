import 'dart:convert';
import 'dart:io';
import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

class ParkingRepository implements RepositoryInterface<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();
  ParkingRepository._internal();
  factory ParkingRepository() => _instance;

  final uri = Uri.parse("http://localhost:8080/parkings");
  

  @override
  Future<List<Parking>> getAll() async {
    try {
      // Fetching from db
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List) {

          return json.map((parking) => Parking.fromJson(parking)).toList();
        } else {
          throw FormatException("Förväntades en List av Parkeringar men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda parkingar. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error i hämtningen av parkingar: $error');
      rethrow;
    }
  }
  
  @override
  Future<Parking?> create(Parking item) async {
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Parking.fromJson(json);
    } else {
      throw Exception('Misslyckades att skapa parkingen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i skapandet av parkingen: $error');
    rethrow;
  }
  }
  
  @override
  Future<Parking?> delete(int id) async {
  try {
    final uriWithId = Uri.parse('$uri/$id');

    final response = await http.delete(
      uriWithId,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Parking.fromJson(json);
      
    } else {
      throw Exception('Misslyckades att ta bort parkingen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i borttagning av parkingen: $error');
    rethrow;
  }
  }
  
  @override
  Future<Parking?> getById(int id) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Fetching from db
      final response = await http.get(uriWithId, headers: {'Content-Type': 'application/json'});

      // Handle 404 Not Found
      if(response.statusCode == 404){
        stdout.writeln("Parkingen hittades inte, vänligen försök igen.");
        return null;
      }
      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Check the response body is not null or unexpected
        if (json != null && json is Map<String, dynamic>) {

          return Parking.fromJson(json);
        }else {
          throw FormatException("Förväntade sig en parking men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda parking. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error att hämta parking: $error');
      rethrow;
    }
  }
  
  @override
  Future<Parking?> update(int id, Parking parking) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Check for successful response
      final response = await http.put(
        uriWithId, 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parking.toJson()));

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Parking.fromJson(json);

      } else {
        throw Exception('Misslyckades att uppdatera parkingen. Statuskod: ${response.statusCode}');

      }
    } catch (error) {
      print('Error i uppdatering av parkingen: $error');
      rethrow;
    }
  }
}