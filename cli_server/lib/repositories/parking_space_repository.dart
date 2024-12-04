import 'package:cli_server/server_config.dart';
import 'package:shared/shared.dart';

class ParkingSpaceRepository implements RepositoryInterface<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;

  Box<ParkingSpace> parkingSpaceBox = ServerConfig.instance.store.box<ParkingSpace>();
  
  @override
  Future<ParkingSpace?> create(ParkingSpace parkingSpace) async {
    
    parkingSpaceBox.put(parkingSpace, mode:PutMode.insert);

    return parkingSpace;
  }
  
  @override
  Future<ParkingSpace?> delete(int id) async {
    ParkingSpace? parkingSpace = parkingSpaceBox.get(id);

    if(parkingSpace != null){
      parkingSpaceBox.remove(id);
    }

    return parkingSpace;
  }
  
  @override
  Future<List<ParkingSpace>> getAll() async {
    
    var parkingSpaceList = parkingSpaceBox.getAllAsync();
    return parkingSpaceList;
  }
  
  @override
  Future<ParkingSpace?> getById(int id) async {
    return parkingSpaceBox.get(id);
  }
  
  @override
  Future<ParkingSpace?> update(int id, ParkingSpace newParkingSpace) async {
    parkingSpaceBox.put(newParkingSpace, mode: PutMode.update);
    return newParkingSpace;
  }
}