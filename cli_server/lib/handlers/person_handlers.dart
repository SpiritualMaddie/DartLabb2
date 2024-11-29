import 'dart:convert';
import 'package:cli_server/repositories/person_repository.dart';
import 'package:shared/models/person.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class PersonHandlers {
  var repoPerson = PersonRepository();

  Response rootHandler(Request req) {
    return Response.ok('Hello, World!\n');
  }

  Future<Response> getAllPersonsHandler(Request req) async {
    try{
      // Fetch all persons
      var persons = await repoPerson.getAll();

      return Response.ok(jsonEncode(persons), headers: {'Content-Type': 'application/json'});
    }catch(error, stacktrace){
      // Log error and stacktrace for debugging
      print('Error occurred: $error \n $stacktrace');

      // Return structured response as JSON
      return Response.internalServerError(
        body: jsonEncode({'error' : 'An error occurred:', 'details': error.toString()}),
        headers: {'Content-Type': 'application/json'}
        );
    }
  }

  Future<Response> createPersonHandler(Request req) async {
    try{

      // Read the request body as a string
      final data = await req.readAsString();

      // Deserialize JSON into a Person instance
      final person = Person.fromJson(jsonDecode(data));

      // Add the person to the list
      await repoPerson.add(person);

      // Return the created person as a reponse
      return Response.ok(jsonEncode(person.toJson()), headers: {'Content-Type': 'application/json'});
    }catch(error){
      return Response.internalServerError(body: 'An error occurred: $error');
    }
  }

  // Future<Response> getPersonByIdHandler(Request req) async {
  //   try{
  //     // Fetch person by id
  //     var personId = req.params['id'];
  //     var persons = await repoPerson.getById(personId);

  //     return Response.ok(jsonEncode(persons), headers: {'Content-Type': 'application/json'});
  //   }catch(error, stacktrace){
  //     // Log error and stacktrace for debugging
  //     print('Error occurred: $error \n $stacktrace');

  //     // Return structured response as JSON
  //     return Response.internalServerError(
  //       body: jsonEncode({'error' : 'An error occurred:', 'details': error.toString()}),
  //       headers: {'Content-Type': 'application/json'}
  //       );
  //   }
  // }

  // Future<Response> updatePersonHandler(Request req) async {
  //   try{

  //     final personId = req.params['id'];
  //     final data = await req.readAsString();

  //     // Deserialize JSON into a Person instance
  //     final person = Person.fromJson(jsonDecode(data));

  //     // Add the person to the list
  //     final personToUpdate = await repoPerson.getById(personId);
  //     final updatedPerson = Person.fromJson(jsonDecode());
  //     await repoPerson.add(person);

  //     // Return the created person as a reponse
  //     return Response.ok(jsonEncode(person.toJson()), headers: {'Content-Type': 'application/json'});
  //   }catch(error){
  //     return Response.internalServerError(body: 'An error occurred: $error');
  //   }
  // }

  // Future<Response> deletePersonHandler(Request req) async {
  //   try {
  //     final personId = req.params['id'];

  //     // Fetch person by ID, if necessary
  //     final personToDelete = await repoPerson.getbyId(personId);
  //     await repoPerson.delete(personToDelete);

  //     return Response.ok('Person deleted successfully');
  //   }catch(error){
  //     return Response.internalServerError(body: 'An error occurred: $error');
  //   }
  // }
}