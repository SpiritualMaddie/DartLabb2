import 'dart:convert';
import 'package:cli_server/repositories/parking_repository.dart';
import 'package:cli_server/utils/request_utils.dart';
import 'package:logger/logger.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';

ParkingRepository repoParking = ParkingRepository();
final logger = Logger();

Future<Response> getAllParkingsHandler(Request req) async {
  try {
    // Fetch all parkings
    var parkings = await repoParking.getAll();

    if (parkings.isNotEmpty) {
      return Response.ok(jsonEncode(parkings),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.ok(jsonEncode({'message': 'No parkings in the db'}),
        headers: {'Content-Type': 'application/json'});
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching all parkings: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> createParkingHandler(Request req) async {
  try {
    // Read the request body as a string
    final data = await req.readAsString();

    if (data.isNotEmpty) {
      // Deserialize JSON into a Parking object
      final parking = Parking.fromJson(jsonDecode(data));

      // Add the parking to the db
      await repoParking.create(parking);

      return Response.ok(jsonEncode(parking.toJson()),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.badRequest(body: 'Request body cannot be empty');
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error creating parking: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> getParkingByIdHandler(Request req) async {
  try {
    // Fetch parkings id
    final parkingId = parseIdFromRequest(req);

    if (parkingId != null) {
      // Fetch parking from db
      var parking = await repoParking.getById(parkingId);

      if (parking != null) {
        return Response.ok(jsonEncode(parking),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('The parking cannot be found.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching parking by id: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> updateParkingHandler(Request req) async {
  try {
    // Fetch and parse parkings id
    final parkingId = parseIdFromRequest(req);

    if (parkingId != null) {
      // Verify that the parking exists in the database
      final existingParking = await repoParking.getById(parkingId);

      if (existingParking != null) {
        final data = await req.readAsString();
        final json = jsonDecode(data);

        if (data.isNotEmpty || json != null) {
          var parking = Parking.fromJson(json);
          var updatedParking = await repoParking.update(parkingId, parking);

          return Response.ok(jsonEncode(updatedParking),
              headers: {'Content-Type': 'application/json'});
        }

        return Response.badRequest(body: 'Invalid request body.');
      }

      return Response.notFound('Parking not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error updating parking: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> deleteParkingHandler(Request req) async {
  try {
    // Fetch parkings id
    final parkingId = parseIdFromRequest(req);

    if (parkingId != null) {
      // Verify that the parking exists in the database
      final existingParking = await repoParking.getById(parkingId);

      if (existingParking != null) {
        var parking = await repoParking.delete(parkingId);

        return Response.ok(jsonEncode(parking),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Parking not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error deleting parking: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}
