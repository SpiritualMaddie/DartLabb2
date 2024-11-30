import 'package:shared/interfaces/respository_interface.dart';
import 'package:shared/models/parking.dart';

class ParkingRepository implements RepositoryInterface<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;
  
  @override
  Future<Parking> create(Parking parking) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<Parking> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<Parking>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
  
  @override
  Future<Parking?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  @override
  Future<Parking> update(int id, Parking parking) {
    // TODO: implement update
    throw UnimplementedError();
  }

}