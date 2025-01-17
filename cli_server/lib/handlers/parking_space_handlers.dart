import 'dart:convert';
import 'package:cli_server/repositories/parking_space_repository.dart';
import 'package:cli_server/utils/request_utils.dart';
import 'package:logger/logger.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';

ParkingSpaceRepository repoParkingSpace = ParkingSpaceRepository();
final logger = Logger();

Future<Response> getAllParkingSpacesHandler(Request req) async {
  try {
    // Fetch all parking spaces
    var parkingspaces = await repoParkingSpace.getAll();

    if (parkingspaces.isNotEmpty) {
      return Response.ok(jsonEncode(parkingspaces),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.ok(jsonEncode({'message': 'No parkingspaces in the db'}),
        headers: {'Content-Type': 'application/json'});
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching all parking spaces: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> createParkingSpaceHandler(Request req) async {
  try {
    // Read the request body as a string
    final data = await req.readAsString();

    if (data.isNotEmpty) {
      // Deserialize JSON into a ParkingSpace object
      final parkingspace = ParkingSpace.fromJson(jsonDecode(data));

      // Add the parkingspace to the db
      await repoParkingSpace.create(parkingspace);

      return Response.ok(jsonEncode(parkingspace.toJson()),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.badRequest(body: 'Request body cannot be empty');
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error creating parking space: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> getParkingSpaceByIdHandler(Request req) async {
  try {
    // Fetch parkingspaces id
    final parkingspaceId = parseIdFromRequest(req);

    if (parkingspaceId != null) {
      // Fetch parkingspace from db
      var parkingspace = await repoParkingSpace.getById(parkingspaceId);

      if (parkingspace != null) {
        return Response.ok(jsonEncode(parkingspace),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('The parking space cannot be found.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching parking space by id: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> updateParkingSpaceHandler(Request req) async {
  try {
    // Fetch and parse parkingspaces id
    final parkingspaceId = parseIdFromRequest(req);

    if (parkingspaceId != null) {
      // Verify that the parkingspace exists in the database
      final existingParkingSpace = await repoParkingSpace.getById(parkingspaceId);

      if (existingParkingSpace != null) {
        final data = await req.readAsString();
        final json = jsonDecode(data);

        if (data.isNotEmpty || json != null) {
          var parkingspace = ParkingSpace.fromJson(json);
          var updatedParkingSpace = await repoParkingSpace.update(parkingspaceId, parkingspace);

          return Response.ok(jsonEncode(updatedParkingSpace),
              headers: {'Content-Type': 'application/json'});
        }

        return Response.badRequest(body: 'Invalid request body.');
      }

      return Response.notFound('Parking space not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error updating parking space: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> deleteParkingSpaceHandler(Request req) async {
  try {
    // Fetch parkingspaces id
    final parkingspaceId = parseIdFromRequest(req);

    if (parkingspaceId != null) {
      // Verify that the parkingspace exists in the database
      final existingParkingSpace = await repoParkingSpace.getById(parkingspaceId);

      if (existingParkingSpace != null) {
        var parkingspace = await repoParkingSpace.delete(parkingspaceId);

        return Response.ok(jsonEncode(parkingspace),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Parking space not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error deleting parking space: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}
