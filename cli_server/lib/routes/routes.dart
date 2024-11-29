import 'package:cli_server/handlers/parking_handlers.dart';
import 'package:cli_server/handlers/parking_space_handlers.dart';
import 'package:cli_server/handlers/person_handlers.dart';
import 'package:cli_server/handlers/vehicle_handlers.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.

var personHandlers = PersonHandlers();
// var vehicleHandlers = VehicleHandlers();
// var parkingSpaceHandlers = ParkingSpaceHandlers();
// var parkingHandlers = ParkingHandlers();
final router = Router()
  
  ..get('/', personHandlers.rootHandler)

  // Person Routes
  ..get('/persons', personHandlers.getAllPersonsHandler)
  ..post('/persons', personHandlers.createPersonHandler)
  // ..get('/getpersonbyid/<id>', personHandlers.getPersonByIdHandler)
  // ..put('/updateperson/<id>', personHandlers.updatePersonHandler)
  // ..delete('/deleteperson/<id>', personHandlers.deletePersonHandler)

  // Vehicle Routes
  ..get('/vehicles', getAllVehiclesHandler)
  ..post('/vehicles', createVehicleHandler)
  ..get('/vehicles/<id>', getVehicleByIdHandler)
  ..put('/vehicles/<id>', updateVehicleHandler)
  ..delete('/vehicles/<id>', deleteVehicleHandler)

  // Parking Space Routes
  ..get('/parkingspaces', getAllParkingSpacesHandler)
  ..post('/parkingspaces', createParkingSpaceHandler)
  ..get('/parkingspaces/<id>', getParkingSpaceByIdHandler)
  ..put('/parkingspaces/<id>', updateParkingSpaceHandler)
  ..delete('/parkingspaces/<id>', deleteParkingSpaceHandler)

  // Parking Routes
  ..get('/parkings', getAllParkingsHandler)
  ..post('/parkings', createParkingHandler)
  ..get('/parkings/<id>', getParkingByIdHandler)
  ..put('/parkings/<id>', updateParkingHandler)
  ..delete('/parkings/<id>', deleteParkingHandler);