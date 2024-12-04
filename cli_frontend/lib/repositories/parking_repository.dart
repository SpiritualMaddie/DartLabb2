import 'package:shared/shared.dart';
//import 'package:http/http.dart' as http;

class ParkingRepository implements RepositoryInterface<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;
  
  @override
  Future<Parking?> create(Parking item) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<Parking?> delete(int id) {
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
  Future<Parking?> update(int id, Parking item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}