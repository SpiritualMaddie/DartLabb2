import 'package:cli_server/server_config.dart';
import 'package:shared/shared.dart';

class VehicleRepository implements RepositoryInterface<Vehicle>{

  static final VehicleRepository _instance = VehicleRepository._internal();
  VehicleRepository._internal();
  factory VehicleRepository() => _instance;
  
  Box<Vehicle> vehicleBox = ServerConfig.instance.store.box<Vehicle>();
  
  @override
  Future<Vehicle?> create(Vehicle vehicle) async {
    vehicleBox.put(vehicle, mode:PutMode.insert);

    return vehicle;
  }
  
  @override
  Future<Vehicle?> delete(int id) async {
    Vehicle? vehicle = vehicleBox.get(id);

    if(vehicle != null){
      vehicleBox.remove(id);
    }

    return vehicle;
  }
  
  @override
  Future<List<Vehicle>> getAll() async {
    return vehicleBox.getAll();
  }
  
  @override
  Future<Vehicle?> getById(int id) async {
    return vehicleBox.get(id);
  }
  
  @override
  Future<Vehicle?> update(int id, Vehicle newVehicle) async {
    vehicleBox.put(newVehicle, mode: PutMode.update);
    return newVehicle;
  }
}