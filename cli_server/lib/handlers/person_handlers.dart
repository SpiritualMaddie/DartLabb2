import 'dart:convert';
import 'package:cli_server/repositories/person_repository.dart';
import 'package:cli_server/utils/request_utils.dart';
import 'package:logger/logger.dart';
import 'package:shared/shared.dart';
import 'package:shelf/shelf.dart';

PersonRepository repoPerson = PersonRepository();
final logger = Logger();

Future<Response> getAllPersonsHandler(Request req) async {
  try {
    // Fetch all persons
    var persons = await repoPerson.getAll();

    if (persons.isNotEmpty) {
      return Response.ok(jsonEncode(persons),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.ok(jsonEncode({'message': 'No persons in the db'}),
        headers: {'Content-Type': 'application/json'});
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching all persons: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> createPersonHandler(Request req) async {
  try {
    // Read the request body as a string
    final data = await req.readAsString();

    if (data.isNotEmpty) {
      // Deserialize JSON into a Person object
      final person = Person.fromJson(jsonDecode(data));

      // Add the person to the db
      await repoPerson.create(person);

      return Response.ok(jsonEncode(person.toJson()),
          headers: {'Content-Type': 'application/json'});
    }

    return Response.badRequest(body: 'Request body cannot be empty');
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error creating person: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> getPersonByIdHandler(Request req) async {
  try {
    // Fetch persons id
    final personId = parseIdFromRequest(req);

    if (personId != null) {
      // Fetch person from db
      var person = await repoPerson.getById(personId);

      if (person != null) {
        return Response.ok(jsonEncode(person),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('The person cannot be found.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error fetching person by id: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> updatePersonHandler(Request req) async {
  try {
    // Fetch and parse persons id
    final personId = parseIdFromRequest(req);

    if (personId != null) {
      // Verify that the person exists in the database
      final existingPerson = await repoPerson.getById(personId);

      if (existingPerson != null) {
        final data = await req.readAsString();
        final json = jsonDecode(data);

        if (data.isNotEmpty || json != null) {
          var person = Person.fromJson(json);
          var updatedPerson = await repoPerson.update(personId, person);

          return Response.ok(jsonEncode(updatedPerson),
              headers: {'Content-Type': 'application/json'});
        }

        return Response.badRequest(body: 'Invalid request body.');
      }

      return Response.notFound('Person not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error updating person: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}

Future<Response> deletePersonHandler(Request req) async {
  try {
    // Fetch persons id
    final personId = parseIdFromRequest(req);

    if (personId != null) {
      // Verify that the person exists in the database
      final existingPerson = await repoPerson.getById(personId);

      if (existingPerson != null) {
        var person = await repoPerson.delete(personId);

        return Response.ok(jsonEncode(person),
            headers: {'Content-Type': 'application/json'});
      }

      return Response.notFound('Person not found in the database.');
    }

    return invalidIdResponse();
  } catch (error, stacktrace) {
    // Log error and stacktrace for debugging
    logger.e(
      "Error deleting person: ${error.runtimeType}",
      error: error,
      stackTrace: stacktrace);

    // Return structured response as JSON
    return handleInternalServerError();
  }
}
