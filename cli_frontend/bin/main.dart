import 'package:cli_frontend/data/dummy_data.dart';
import '../lib/application.dart';

Future<void> main(List<String> args) async{
  Application startApp = Application();
  DummyData dummyData = DummyData();

  dummyData.populateDb();
  startApp.startMenu();
}

