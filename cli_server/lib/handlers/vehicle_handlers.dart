import 'dart:convert';
import 'package:cli_server/repositories/vehicle_repository.dart';
import 'package:cli_server/utils/request_utils.dart';
import 'package:logger/logger.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';

VehicleRepository repoVehicle = VehicleRepository();
final logger = Logger();

Future<Response> getAllVehiclesHandler(Request req) async {
  try {
    // Fetch all vehicles
    var vehicles = await repoVehicle.getAll();

    if (vehicles.isNotEmpty) {
      return Response.ok(jsonEncode(vehicles),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.ok(jsonEncode({'message': 'No vehicles in the db'}),
        headers: {'Content-Type': 'application/json'});
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching all vehicles: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> createVehicleHandler(Request req) async {
  try {
    // Read the request body as a string
    final data = await req.readAsString();

    if (data.isNotEmpty) {
      // Deserialize JSON into a Vehicle object
      final vehicle = Vehicle.fromJson(jsonDecode(data));

      // Add the vehicle to the db
      await repoVehicle.create(vehicle);

      return Response.ok(jsonEncode(vehicle.toJson()),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.badRequest(body: 'Request body cannot be empty');
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error creating vehicle: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> getVehicleByIdHandler(Request req) async {
  try {
    // Fetch vehicles id
    final vehicleId = parseIdFromRequest(req);

    if (vehicleId != null) {
      // Fetch vehicle from db
      var vehicle = await repoVehicle.getById(vehicleId);

      if (vehicle != null) {
        return Response.ok(jsonEncode(vehicle),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('The vehicle cannot be found.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching vehicle by id: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> updateVehicleHandler(Request req) async {
  try {
    // Fetch and parse vehicles id
    final vehicleId = parseIdFromRequest(req);

    if (vehicleId != null) {
      // Verify that the vehicle exists in the database
      final existingVehicle = await repoVehicle.getById(vehicleId);

      if (existingVehicle != null) {
        final data = await req.readAsString();
        final json = jsonDecode(data);

        if (data.isNotEmpty || json != null) {
          var vehicle = Vehicle.fromJson(json);
          var updatedVehicle = await repoVehicle.update(vehicleId, vehicle);

          return Response.ok(jsonEncode(updatedVehicle),
              headers: {'Content-Type': 'application/json'});
        }

        return Response.badRequest(body: 'Invalid request body.');
      }

      return Response.notFound('Vehicle not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error updating vehicle: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> deleteVehicleHandler(Request req) async {
  try {
    // Fetch vehicles id
    final vehicleId = parseIdFromRequest(req);

    if (vehicleId != null) {
      // Verify that the vehicle exists in the database
      final existingVehicle = await repoVehicle.getById(vehicleId);

      if (existingVehicle != null) {
        var vehicle = await repoVehicle.delete(vehicleId);

        return Response.ok(jsonEncode(vehicle),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Vehicle not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error deleting vehicle: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}
