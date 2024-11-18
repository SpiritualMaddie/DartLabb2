import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  // Person Routes
  ..get('/persons', _getAllPersonsHandler)
  ..post('/persons', _createPersonHandler)
  ..get('/persons/<id>', _getPersonByIdHandler)
  ..put('/persons/<id>', _updatePersonHandler)
  ..delete('/persons/<id>', _deletePersonHandler)

  // Vehicle Routes
  ..get('/vehicles', _getAllVehiclesHandler)
  ..post('/vehicles', _createVehicleHandler)
  ..get('/vehicles/<id>', _getVehicleByIdHandler)
  ..put('/vehicles/<id>', _updateVehicleHandler)
  ..delete('/vehicles/<id>', _deleteVehicleHandler)

  // Parking Space Routes
  ..get('/parkingspaces', _getAllParkingSpacesHandler)
  ..post('/parkingspaces', _createParkingSpaceHandler)
  ..get('/parkingspaces/<id>', _getParkingSpaceByIdHandler)
  ..put('/parkingspaces/<id>', _updateParkingSpaceHandler)
  ..delete('/parkingspaces/<id>', _deleteParkingSpaceHandler)

  // Parking Routes
  ..get('/parkings', _getAllParkingsHandler)
  ..post('/parkings', _createParkingHandler)
  ..get('/parkings/<id>', _getParkingByIdHandler)
  ..put('/parkings/<id>', _updateParkingHandler)
  ..delete('/parkings/<id>', _deleteParkingHandler);


  // Handlers
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

// Person Handlers
Future<Response> _getAllPersonsHandler(Request request) async {
  // Implement logic to get all persons
  return Response.ok('Get all persons');
}

Future<Response> _createPersonHandler(Request request) async {
  //   Implement logic to create a new person
  return Response.ok('Create person');
}

Future<Response> _getPersonByIdHandler(Request request) async {
  //   Implement logic to get a person by ID
  return Response.ok('Get person by ID');
}

Future<Response> _updatePersonHandler(Request request) async {
  //   Implement logic to update a person by ID
  return Response.ok('Update person by ID');
}

Future<Response> _deletePersonHandler(Request request) async {
  //   Implement logic to delete a person by ID
  return Response.ok('Delete person by ID');
}

// Vehicle Handlers
Future<Response> _getAllVehiclesHandler(Request request) async {
  //   Implement logic to get all vehicles
  return Response.ok('Get all vehicles');
}

Future<Response> _createVehicleHandler(Request request) async {
  //   Implement logic to create a new vehicle
  return Response.ok('Create vehicle');
}

Future<Response> _getVehicleByIdHandler(Request request) async {
  //   Implement logic to get a vehicle by ID
  return Response.ok('Get vehicle by ID');
}

Future<Response> _updateVehicleHandler(Request request) async {
  //   Implement logic to update a vehicle by ID
  return Response.ok('Update vehicle by ID');
}

Future<Response> _deleteVehicleHandler(Request request) async {
  //   Implement logic to delete a vehicle by ID
  return Response.ok('Delete vehicle by ID');
}

// Parking Space Handlers
Future<Response> _getAllParkingSpacesHandler(Request request) async {
  //   Implement logic to get all parking spaces
  return Response.ok('Get all parking spaces');
}

Future<Response> _createParkingSpaceHandler(Request request) async {
  //   Implement logic to create a new parking space
  return Response.ok('Create parking space');
}

Future<Response> _getParkingSpaceByIdHandler(Request request) async {
  //   Implement logic to get a parking space by ID
  return Response.ok('Get parking space by ID');
}

Future<Response> _updateParkingSpaceHandler(Request request) async {
  //   Implement logic to update a parking space by ID
  return Response.ok('Update parking space by ID');
}

Future<Response> _deleteParkingSpaceHandler(Request request) async {
  //   Implement logic to delete a parking space by ID
  return Response.ok('Delete parking space by ID');
}

// Parking Handlers
Future<Response> _getAllParkingsHandler(Request request) async {
  //   Implement logic to get all parkings
  return Response.ok('Get all parkings');
}

Future<Response> _createParkingHandler(Request request) async {
  //   Implement logic to create a new parking
  return Response.ok('Create parking');
}

Future<Response> _getParkingByIdHandler(Request request) async {
  //   Implement logic to get a parking by ID
  return Response.ok('Get parking by ID');
}

Future<Response> _updateParkingHandler(Request request) async {
  //   Implement logic to update a parking by ID
  return Response.ok('Update parking by ID');
}

Future<Response> _deleteParkingHandler(Request request) async {
  //   Implement logic to delete a parking by ID
  return Response.ok('Delete parking by ID');
}



void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}


  // Blueprint
  //..post('/items', _postItemHandler);
// Blueprint
// Future<Response> _postItemHandler(Request request) async {
//   final data = await request.readAsString();
//   final json = jsonDecode(data);

//   print(json);

//   return Response.ok("yey");
// }