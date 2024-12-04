import 'package:shared/shared.dart';
//import 'package:http/http.dart' as http;

class ParkingSpaceRepository implements RepositoryInterface<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;
  
  @override
  Future<ParkingSpace?> create(ParkingSpace item) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<ParkingSpace?> delete(int id) {
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
  Future<ParkingSpace?> update(int id, ParkingSpace item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}