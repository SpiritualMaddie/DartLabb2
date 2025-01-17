import 'dart:convert';
import 'dart:io';
import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

class VehicleRepository implements RepositoryInterface<Vehicle>{

  static final VehicleRepository _instance = VehicleRepository._internal();
  VehicleRepository._internal();
  factory VehicleRepository() => _instance;

  final uri = Uri.parse("http://localhost:8080/vehicles");
  

  @override
  Future<List<Vehicle>> getAll() async {
    try {
      // Fetching from db
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List) {

          return json.map((vehicle) => Vehicle.fromJson(vehicle)).toList();
        } else {
          throw FormatException("Förväntades en List av Vehicles men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda fordon. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error i hämtningen av fordon: $error');
      rethrow;
    }
  }
  
  @override
  Future<Vehicle?> create(Vehicle item) async {
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Vehicle.fromJson(json);
    } else {
      throw Exception('Misslyckades att skapa fordonet. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i skapandet av fordonet: $error');
    rethrow;
  }
  }
  
  @override
  Future<Vehicle?> delete(int id) async {
  try {
    final uriWithId = Uri.parse('$uri/$id');

    final response = await http.delete(
      uriWithId,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Vehicle.fromJson(json);
      
    } else {
      throw Exception('Misslyckades att ta bort fordonet. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i borttagning av fordonet: $error');
    rethrow;
  }
  }
  
  @override
  Future<Vehicle?> getById(int id) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Fetching from db
      final response = await http.get(uriWithId, headers: {'Content-Type': 'application/json'});

      // Handle 404 Not Found
      if(response.statusCode == 404){
        stdout.writeln("Fordonet hittades inte, vänligen försök igen.");
        return null;
      }
      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Check the response body is not null or unexpected
        if (json != null && json is Map<String, dynamic>) {

          return Vehicle.fromJson(json);
        }else {
          throw FormatException("Förväntade sig ett fordon men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda fordonet. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error att hämta fordonet: $error');
      rethrow;
    }
  }
  
  @override
  Future<Vehicle?> update(int id, Vehicle vehicle) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Check for successful response
      final response = await http.put(
        uriWithId, 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vehicle.toJson()));

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Vehicle.fromJson(json);

      } else {
        throw Exception('Misslyckades att uppdatera fordonet. Statuskod: ${response.statusCode}');

      }
    } catch (error) {
      print('Error i uppdatering av fordonet: $error');
      rethrow;
    }
  }
}