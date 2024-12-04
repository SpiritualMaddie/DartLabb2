import 'package:shared/shared.dart';
//import 'package:http/http.dart' as http;

class VehicleRepository implements RepositoryInterface<Vehicle>{

  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;
  
  @override
  Future<Vehicle?> create(Vehicle item) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<Vehicle?> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<Vehicle>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
  
  @override
  Future<Vehicle?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  @override
  Future<Vehicle?> update(int id, Vehicle item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}