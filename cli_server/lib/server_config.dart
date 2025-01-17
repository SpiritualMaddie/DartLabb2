import 'package:shared/shared.dart';

import 'package:shelf_router/shelf_router.dart';
import 'package:cli_server/handlers/person_handlers.dart';
import 'package:cli_server/handlers/parking_handlers.dart';
import 'package:cli_server/handlers/vehicle_handlers.dart';
import 'package:cli_server/handlers/parking_space_handlers.dart';

class ServerConfig {

  ServerConfig._privateConstructor(){
    initialize();
    }

  static final ServerConfig _instance = ServerConfig._privateConstructor();

  static ServerConfig get instance => _instance;

  late Store store;
  late Router router;

  initialize(){
    // Configure routes.

    router = Router();
    store = openStore();

    // Person Routes
    router.get('/persons', getAllPersonsHandler); // List all persons
    router.post('/persons', createPersonHandler); // Create a new person
    router.get('/persons/<id>', getPersonByIdHandler); // Get a specific person
    router.put('/persons/<id>', updatePersonHandler); // Update a specific person
    router.delete('/persons/<id>', deletePersonHandler); // Delete a specific person


    // Vehicle Routes
    router.get('/vehicles', getAllVehiclesHandler);
    router.post('/vehicles', createVehicleHandler);
    router.get('/vehicles/<id>', getVehicleByIdHandler);
    router.put('/vehicles/<id>', updateVehicleHandler);
    router.delete('/vehicles/<id>', deleteVehicleHandler);

    // ParkingSpace Routes
    router.get('/parkingspaces', getAllParkingSpacesHandler);
    router.post('/parkingspaces', createParkingSpaceHandler);
    router.get('/parkingspaces/<id>', getParkingSpaceByIdHandler);
    router.put('/parkingspaces/<id>', updateParkingSpaceHandler);
    router.delete('/parkingspaces/<id>', deleteParkingSpaceHandler);

    // Parking Routes
    router.get('/parkings', getAllParkingsHandler);
    router.post('/parkings', createParkingHandler);
    router.get('/parkings/<id>', getParkingByIdHandler);
    router.put('/parkings/<id>', updateParkingHandler);
    router.delete('/parkings/<id>', deleteParkingHandler);
  }
}