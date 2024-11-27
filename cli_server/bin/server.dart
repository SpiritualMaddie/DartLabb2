import 'dart:io';
import 'package:cli_server/routes/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(router.call);

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