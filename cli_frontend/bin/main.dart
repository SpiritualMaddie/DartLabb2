import '../lib/application.dart';

Future<void> main(List<String> args) async{
  Application startApp = Application();

  await startApp.startMenu();
}

