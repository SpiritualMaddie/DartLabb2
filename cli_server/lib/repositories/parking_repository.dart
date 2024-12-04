import 'package:cli_server/server_config.dart';
import 'package:shared/shared.dart';

class ParkingRepository implements RepositoryInterface<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

  Box<Parking> parkingBox = ServerConfig.instance.store.box<Parking>();
  
  @override
  Future<Parking?> create(Parking parking) async {
    
    parkingBox.put(parking, mode:PutMode.insert);

    return parking;
  }
  
  @override
  Future<Parking?> delete(int id) async {
    Parking? parking = parkingBox.get(id);

    if(parking != null){
      parkingBox.remove(id);
    }

    return parking;
  }
  
  @override
  Future<List<Parking>> getAll() async {
    
    var parkingList = parkingBox.getAllAsync();
    return parkingList;
  }
  
  @override
  Future<Parking?> getById(int id) async {
    return parkingBox.get(id);
  }
  
  @override
  Future<Parking?> update(int id, Parking newParking) async {
    parkingBox.put(newParking, mode: PutMode.update);
    return newParking;
  }
}