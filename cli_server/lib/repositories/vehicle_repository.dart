import 'package:shared/interfaces/respository_interface.dart';
import 'package:shared/models/vehicle.dart';


class VehicleRepository implements RepositoryInterface<Vehicle>{

  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;
  
  @override
  Future<Vehicle> create(Vehicle vehicle) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<Vehicle> delete(int id) {
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
  Future<Vehicle> update(int id, Vehicle vehicle) {
    // TODO: implement update
    throw UnimplementedError();
  }
}