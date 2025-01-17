import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

int? parseIdFromRequest(Request req){
  final idString = req.params['id'];
  return int.tryParse(idString ?? '');
}

Response invalidIdResponse(){
  return Response.badRequest(body: 'The id must be an integer');
}

Response handleInternalServerError(){
  return Response.internalServerError(
    body: jsonEncode(
        {'error': 'An error occurred.'}),
    headers: {'Content-Type': 'application/json'});
}