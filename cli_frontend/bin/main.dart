import '../lib/application.dart';
import '../data/dummy_data.dart';

void main(List<String> args) async{
  Application startApp = Application();
  DummyData dummyData = DummyData();

  dummyData.populateDb();
  startApp.startMenu();
}

