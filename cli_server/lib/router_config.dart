import 'package:cli_server/handlers/parking_handlers.dart';
import 'package:cli_server/handlers/parking_space_handlers.dart';
import 'package:cli_server/handlers/person_handlers.dart';
import 'package:cli_server/handlers/vehicle_handlers.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfig {
  static Router initialize(){
    
    // Configure routes.
    final router = Router();
    var personHandlers = PersonHandlers();
    // var vehicleHandlers = VehicleHandlers();
    // var parkingSpaceHandlers = ParkingSpaceHandlers();
    // var parkingHandlers = ParkingHandlers();

    
    router.get('/', personHandlers.rootHandler);

    // Person Routes
    router.get('/persons', personHandlers.getAllPersonsHandler);
    router.post('/persons', personHandlers.createPersonHandler);
    // router.get('/getpersonbyid/<id>', personHandlers.getPersonByIdHandler);
    // router.put('/updateperson/<id>', personHandlers.updatePersonHandler);
    // router.delete('/deleteperson/<id>', personHandlers.deletePersonHandler);

    // Vehicle Routes
    router.get('/vehicles', getAllVehiclesHandler);
    router.post('/vehicles', createVehicleHandler);
    router.get('/vehicles/<id>', getVehicleByIdHandler);
    router.put('/vehicles/<id>', updateVehicleHandler);
    router.delete('/vehicles/<id>', deleteVehicleHandler);

    // Parking Space Routes
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
    
    return router;
  }
}