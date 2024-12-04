import 'package:shelf/shelf.dart';
//import 'package:shared/shared.dart';

// Parking Handlers
Future<Response> getAllParkingsHandler(Request req) async {
  //   Implement logic to get all parkings
  return Response.ok('Get all parkings');
}

Future<Response> createParkingHandler(Request req) async {
  //   Implement logic to create a new parking
  return Response.ok('Create parking');
}

Future<Response> getParkingByIdHandler(Request req) async {
  //   Implement logic to get a parking by ID
  return Response.ok('Get parking by ID');
}

Future<Response> updateParkingHandler(Request req) async {
  //   Implement logic to update a parking by ID
  return Response.ok('Update parking by ID');
}

Future<Response> deleteParkingHandler(Request req) async {
  //   Implement logic to delete a parking by ID
  return Response.ok('Delete parking by ID');
}