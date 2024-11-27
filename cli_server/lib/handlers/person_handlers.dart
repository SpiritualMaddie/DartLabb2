import 'dart:convert';
import 'package:cli_server/repositories/person_repository.dart';
import 'package:shelf/shelf.dart';

class PersonHandlers {
  var repoPerson = PersonRepository();

  Response rootHandler(Request req) {
    return Response.ok('Hello, World!\n');
  }

  Future<Response> getAllPersonsHandler(Request req) async {
    try{
      var persons = await repoPerson.getAll();

      return Response.ok(jsonEncode(persons), headers: {'Content-Type': 'application/json'});
    }catch(error){
      return Response.internalServerError(body: 'An error occurred: $error');
    }
  }

  Future<Response> createPersonHandler(Request req) async {
    //   Implement logic to create a new person
    return Response.ok('Create person');
  }

  Future<Response> getPersonByIdHandler(Request req) async {
    //   Implement logic to get a person by ID
    return Response.ok('Get person by ID');
  }

  Future<Response> updatePersonHandler(Request req) async {
    //   Implement logic to update a person by ID
    return Response.ok('Update person by ID');
  }

  Future<Response> deletePersonHandler(Request req) async {
    //   Implement logic to delete a person by ID
    return Response.ok('Delete person by ID');
  }

}