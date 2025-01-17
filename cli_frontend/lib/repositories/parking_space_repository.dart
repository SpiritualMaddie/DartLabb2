import 'dart:convert';
import 'dart:io';
import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

class ParkingSpaceRepository implements RepositoryInterface<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();
  ParkingSpaceRepository._internal();
  factory ParkingSpaceRepository() => _instance;

  final uri = Uri.parse("http://localhost:8080/parkingspaces");
  

  @override
  Future<List<ParkingSpace>> getAll() async {
    try {
      // Fetching from db
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List) {

          return json.map((parkingSpace) => ParkingSpace.fromJson(parkingSpace)).toList();
        } else {
          throw FormatException("Förväntades en List av parkeringsplatser men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda parkeringsplatser. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error i hämtningen av parkeringsplatser: $error');
      rethrow;
    }
  }
  
  @override
  Future<ParkingSpace?> create(ParkingSpace item) async {
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ParkingSpace.fromJson(json);
    } else {
      throw Exception('Misslyckades att skapa parkeringsplatsen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i skapandet av parkeringsplatsen: $error');
    rethrow;
  }
  }
  
  @override
  Future<ParkingSpace?> delete(int id) async {
  try {
    final uriWithId = Uri.parse('$uri/$id');

    final response = await http.delete(
      uriWithId,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ParkingSpace.fromJson(json);
      
    } else {
      throw Exception('Misslyckades att ta bort parkeringsplatsen. Statuskod: ${response.statusCode}');
    }
  } catch (error) {
    print('Error i borttagning av parkeringsplatsen: $error');
    rethrow;
  }
  }
  
  @override
  Future<ParkingSpace?> getById(int id) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Fetching from db
      final response = await http.get(uriWithId, headers: {'Content-Type': 'application/json'});

      // Handle 404 Not Found
      if(response.statusCode == 404){
        stdout.writeln("Parkeringsplatsen hittades inte, vänligen försök igen.");
        return null;
      }
      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Check the response body is not null or unexpected
        if (json != null && json is Map<String, dynamic>) {

          return ParkingSpace.fromJson(json);
        }else {
          throw FormatException("Förväntade sig en parkeringsplats men fick: ${json.runtimeType}");
        }
      } else {
        throw Exception('Misslyckades att ladda parkeringsplatsen. Statuskod: ${response.statusCode}');
      }
    } catch (error) {
      print('Error att hämta parkeringsplatsen: $error');
      rethrow;
    }
  }
  
  @override
  Future<ParkingSpace?> update(int id, ParkingSpace parkingSpace) async {
    try {
      // Construct the full uri with the id
      final uriWithId = Uri.parse('$uri/$id');

      // Check for successful response
      final response = await http.put(
        uriWithId, 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parkingSpace.toJson()));

      // Check for successful response
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ParkingSpace.fromJson(json);

      } else {
        throw Exception('Misslyckades att uppdatera parkeringsplatsen. Statuskod: ${response.statusCode}');

      }
    } catch (error) {
      print('Error i uppdatering av parkeringsplatsen: $error');
      rethrow;
    }
  }
}