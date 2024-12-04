import 'dart:io';

import 'package:cli_server/data/dummy_data.dart';
import 'package:cli_server/server_config.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Instantialize router class to access routes
  Router router = ServerConfig.instance.router;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  // Running seed data
  DummyData dummyData = DummyData();
  dummyData.seedData();

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  // Sigint handler
  ProcessSignal.sigint.watch().listen((ProcessSignal signal){
    print('clean shutdown');
    server.close(force: true);
    ServerConfig.instance.store.close();
    exit(0);
   });
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