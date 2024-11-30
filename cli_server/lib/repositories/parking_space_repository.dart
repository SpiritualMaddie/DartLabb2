import 'package:shared/interfaces/respository_interface.dart';
import 'package:shared/models/parking_space.dart';

class ParkingSpaceRepository implements RepositoryInterface<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;
  
  @override
  Future<ParkingSpace> create(ParkingSpace parkingSpace) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<ParkingSpace> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<ParkingSpace>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
  
  @override
  Future<ParkingSpace?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  @override
  Future<ParkingSpace> update(int id, ParkingSpace parkingSpace) {
    // TODO: implement update
    throw UnimplementedError();
  }
}