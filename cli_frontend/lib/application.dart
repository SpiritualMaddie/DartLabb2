import 'dart:io';

import 'package:cli_frontend/repositories/parking_repository.dart';
import 'package:cli_frontend/repositories/parking_space_repository.dart';
import 'package:cli_frontend/repositories/person_repository.dart';
import 'package:cli_frontend/repositories/vehicle_repository.dart';

import 'package:cli_frontend/ui/menu.dart';
import 'package:cli_frontend/ui/person_ui.dart';
import 'package:cli_frontend/ui/vehicle_ui.dart';
import 'package:cli_frontend/ui/parking_ui.dart';
import 'package:cli_frontend/ui/parking_space_ui.dart';
import 'package:cli_frontend/utils/console_utils.dart';




class Application{
  static final Application _instance = Application._internal();
  Application._internal();
  factory Application() => _instance;

  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();
  var consoleUtils = ConsoleUtils();
  var personUi = PersonUi();
  var vehicleUi = VehicleUi();
  var parkingSpaceUi = ParkingSpaceUi();
  var parkingUi = ParkingUi();


// ************************* START MENU ***********************************************
Future<void> startMenu() async{

  while (true) {
    consoleUtils.clearConsole();
    String prompt = "Vad vill du göra?\n";

    List<String> options = ["1. Parkera mitt fordon",
                            "2. Avsluta parkering",
                            "3. Parkeringar - se, lägg till/redigera", 
                            "4. Person - se, lägg till/redigera", 
                            "5. Fordon - se, lägg till/redigera", 
                            "6. Parkeringsplatser - se, lägg till/redigera", 
                            "7. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    consoleUtils.logo();
    print(mainMenu);

    try{

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch (input) {
        case "1":
          await parkingUi.createNewParking();    
          break;
        case "2":
          await parkingUi.endParking();    
          break;
        case "3":
          await parkingsMenu();      
          break;
        case "4":
          await personMenu();        
          break;
        case "5":
          await vehicleMenu();       
          break;
        case "6":
          await parkingSpacesMenu();
          break;
        case "7":
          consoleUtils.endScreen();
        default:
          consoleUtils.invalidChoice();
      }
    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }
}

// ************************* PERSON MENU **********************************************
Future<void> personMenu() async{

  while (true) {
    consoleUtils.clearConsole();
    String prompt = "Här kan du hantera användare\n";

    List<String> options = ["1. Lägg till ny användare", 
                            "2. Visa alla användare och hantera dom", 
                            "3. Sök efter användare med id",
                            "4. Tillbaka till startmenyn", 
                            "5. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    try{

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch (input) {
        case "1":
          await personUi.createNewPerson();
          break;
        case "2":
          await personUi.managePerson();
          break;
        case "3":
          await personUi.searchPerson();        
          break;
        case "4":
          await startMenu();        
          break;
        case "5":
          consoleUtils.endScreen();
        default:
          consoleUtils.invalidChoice();
      }
    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }
}

// ************************* VEHICLE MENU *********************************************
Future<void> vehicleMenu() async{

  while(true){
    consoleUtils.clearConsole();
    String prompt = "Här kan du hantera fordon\n";

    List<String> options = ["1. Lägg till nytt fordon", 
                            "2. Visa alla fordon och hantera dom", 
                            "3. Sök efter fordon med id", 
                            "4. Tillbaka till startmenyn",
                            "5. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    try{

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch (input) {
        case "1":
          await vehicleUi.createNewVehicle();      
          break;
        case "2":
          await vehicleUi.manageVehicle();       
          break;
        case "3":
          await vehicleUi.searchVehicle();        
          break;
        case "4":
          await startMenu();        
          break;
        case "5":
          consoleUtils.endScreen();
        default:
          consoleUtils.invalidChoice();
      }
    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }
}

// ************************* PARKINGS MENU ********************************************
Future<void> parkingsMenu() async{

  while(true){
    consoleUtils.clearConsole();
    String prompt = "Här kan du hantera parkeringar\n";

    List<String> options = ["1. Lägg till en parkering", 
                            "2. Visa alla parkeringar och hantera dom", 
                            "3. Sök efter parking med id", 
                            "4. Tillbaka till startmenyn", 
                            "5. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    try{

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch (input) {
        case "1":
          await parkingUi.createNewParking();      
          break;
        case "2":
          await parkingUi.manageParking();       
          break;
        case "3":
          await parkingUi.searchParking();        
          break;
        case "4":
          await startMenu();        
          break;
        case "5":
          consoleUtils.endScreen();
        default:
          consoleUtils.invalidChoice();
      }
    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }
}

// ************************* PARKINGSPACES MENU ***************************************
Future<void> parkingSpacesMenu() async{

  while(true){
    consoleUtils.clearConsole();
    String prompt = "Här kan du hantera parkerinsplatser\n";

    List<String> options = ["1. Lägg till en parkeringsplats", 
                            "2. Visa alla parkeringsplatser och hantera dom", 
                            "3. Sök efter parkingsplats med id", 
                            "4. Tillbaka till startmenyn", 
                            "5. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    try{

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch (input) {
        case "1":
          await parkingSpaceUi.createNewParkingSpace();      
          break;
        case "2":
          await parkingSpaceUi.manageParkingSpace();       
          break;
        case "3":
          await parkingSpaceUi.searchParkingSpace();        
          break;
        case "4":
          await startMenu();        
          break;
        case "5":
          consoleUtils.endScreen();
        default:
          consoleUtils.invalidChoice();
      }
    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }
}

}