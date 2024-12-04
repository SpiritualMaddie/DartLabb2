import 'package:cli_frontend/repositories/parking_repository.dart';
import 'package:cli_frontend/repositories/parking_space_repository.dart';
import 'package:cli_frontend/repositories/vehicle_repository.dart';

import 'package:cli_frontend/ui/parking_space_ui.dart';
import 'package:cli_frontend/ui/vehicle_ui.dart';
import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/shared.dart';

//import 'package:http/http.dart' as http;
import 'dart:io';


class ParkingUi {
  static final ParkingUi _instance = ParkingUi._internal();
  ParkingUi._internal();
  factory ParkingUi() => _instance;

  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();
  var vehicleUi = VehicleUi();
  var parkingSpaceUi = ParkingSpaceUi();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  Future<void> createNewParking() async{
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till en ny parkering\n");  
            
      stdout.writeln("Alla fordon i systemet:");
      stdout.writeln("\n-----------------------------------------------------------\n");
    
      var vehicles = await repoVehicle.getAll();
      if (vehicles.isEmpty) {
        stdout.writeln("Inga fordon finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }
    
      for (var i = 0; i < vehicles.length; i++) {
        stdout.writeln("${i + 1}. ${vehicles[i]}");
      }
      
      stdout.writeln("\n-----------------------------------------------------------\n");
      stdout.write("Välj ett nummer för att välja ett fordon att parkera (eller 'b' för att gå tillbaka): ");
      stdout.write("\nFinns inte fordonet som önskas var vänlig lägg till denne först (välj 'f' för att komma dit)");
      
      var vehicleChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      
      if (vehicleChoice == 'b') {
        return;
      }
      if (vehicleChoice == 'f') {
        vehicleUi.createNewVehicle();
      }
      
      // Check if vehicle exists
      var index = int.tryParse(vehicleChoice);
      if (index == null || index < 1 || index > vehicles.length) {
        consoleUtils.invalidChoice();
        continue;
      }
      
      consoleUtils.clearConsole();
      var selectedVehicle = vehicles[index - 1];
      stdout.writeln("Du har valt:\n ${selectedVehicle}");
      stdout.writeln("Vill du parkera detta fordon? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (choice == 'ja') {

        stdout.writeln("Alla parkeringsplatser i systemet:");
        stdout.writeln("\n-----------------------------------------------------------\n");
      
        var parkingSpaces = await repoParkingSpace.getAll();
        if (parkingSpaces.isEmpty) {
          stdout.writeln("Inga parkeringsplatser finns i systemet.");
          await Future.delayed(Duration(seconds: 3));
          return;
        }
      
        for (var i = 0; i < parkingSpaces.length; i++) {
          stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
        }
        
        stdout.writeln("\n-----------------------------------------------------------\n");
        stdout.write("Välj ett nummer för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");
        stdout.write("\nFinns inte parkeringsplatsen som önskas var vänlig lägg till denne först (välj 'p' för att komma dit)");
        
        var psInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (psInput == 'b') {
          return;
        }
        if (psInput == 'p') {
          parkingSpaceUi.createNewParkingSpace();
        }
        
        // Check if space exists
        var index = int.tryParse(psInput);
        if (index == null || index < 1 || index > parkingSpaces.length) {
          consoleUtils.invalidChoice();
          continue;
        }
        
        consoleUtils.clearConsole();
        var selectedPs = parkingSpaces[index - 1];
        stdout.writeln("Du har valt:\n ${selectedPs}");
        stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

        var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if(psChoice == "ja"){

        int? parkingId = inputUtils.getValidIntPrice("Parkingsid (heltal tresiffrigt, börjar med 4 (tex 406))");
        if(parkingId == null){
          consoleUtils.invalidChoice();
          continue;
        }

          // HTTP REQUEST
          await repoParking.create(Parking(parkingId: parkingId, vehicleId: selectedVehicle.vehicleId, parkingSpaceId: selectedPs.parkingSpaceId, startTime: DateTime.now()));
          stdout.write("Parkeringen har lagts till.");
          await Future.delayed(Duration(seconds: 3));        
          return;
        }else if(psChoice == "nej"){
          continue;
        }else{
          consoleUtils.invalidChoice();
          continue;
        }

      }else if(choice == "nej"){
        continue;
      }else{
        consoleUtils.invalidChoice();
        continue;
      }
    }  
}

Future<void> manageParking() async {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringar");
    stdout.writeln("Alla parkeringar i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    // HTTP REQUEST
    var parkings = await repoParking.getAll();
    if (parkings.isEmpty) {
      stdout.writeln("Inga parkeringar finns i systemet.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
    
    for (var i = 0; i < parkings.length; i++) {
      stdout.writeln("${i + 1}. ${parkings[i]}");
    }
    
    // Lets user choose a parkings to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en parkering (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkings.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedParking = parkings[index - 1];
    stdout.writeln("Du har valt: ${selectedParking}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna parkering? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit parking
    if (action == 'e') {
      while (true) {

        // Shows all vehicles to choose from
        stdout.writeln("Alla fordon i systemet:");
        stdout.writeln("\n-----------------------------------------------------------\n");
      
        var vehicles = await repoVehicle.getAll();
        if (vehicles.isEmpty) {
          stdout.writeln("Inga fordon finns i systemet.");
          await Future.delayed(Duration(seconds: 3));
          return;
        }
      
        for (var i = 0; i < vehicles.length; i++) {
          stdout.writeln("${i + 1}. ${vehicles[i]}");
        }
        
        stdout.writeln("\n-----------------------------------------------------------\n");
        stdout.write("Välj ett nummer för att ändra fordon (eller 'b' för att gå tillbaka): ");
        stdout.write("\nFinns inte fordonet som önskas var vänlig lägg till denne först (välj 'f' för att komma dit)");
        
        var vehicleChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (vehicleChoice == 'b') {
          return;
        }
        if (vehicleChoice == 'f') {
          vehicleUi.createNewVehicle();
        }
        
        // Check if vehicle exists
        var index = int.tryParse(vehicleChoice);
        if (index == null || index < 1 || index > vehicles.length) {
          consoleUtils.invalidChoice();
          continue;
        }
        
        consoleUtils.clearConsole();
        var selectedVehicle = vehicles[index - 1];
        stdout.writeln("Du har valt: ${selectedVehicle}");
        stdout.writeln("Vill du parkera detta fordon? (ja/nej)");

        var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if (choice == 'ja') {

          stdout.writeln("Alla parkeringsplatser i systemet:");
          stdout.writeln("\n-----------------------------------------------------------\n");
        
          // HTTP REQUEST
          var parkingSpaces = await repoParkingSpace.getAll();
          if (parkingSpaces.isEmpty) {
            stdout.writeln("Inga parkeringsplatser finns i systemet.");
            await Future.delayed(Duration(seconds: 3));
            return;
          }
        
          for (var i = 0; i < parkingSpaces.length; i++) {
            stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
          }
          
          stdout.writeln("\n-----------------------------------------------------------\n");
          stdout.write("Välj ett nummer för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");
          stdout.write("\nFinns inte parkeringsplatsen som önskas var vänlig lägg till denne först (välj 'p' för att komma dit)");
          
          var psInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";
          
          if (psInput == 'b') {
            return;
          }
          if (psInput == 'p') {
            parkingSpaceUi.createNewParkingSpace();
          }
          
          // Check if space exists
          var index = int.tryParse(psInput);
          if (index == null || index < 1 || index > parkingSpaces.length) {
            consoleUtils.invalidChoice();
            continue;
          }
          
          consoleUtils.clearConsole();
          var selectedPs = parkingSpaces[index - 1];
          stdout.writeln("Du har valt: ${selectedPs}");
          stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

          var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

          if(psChoice == "ja"){

            if(selectedParking.endTimeStatus == "pågående"){
              stdout.writeln("Vill du ändra sluttiden från 'pågående' till 'avslutad'? (ja/nej)");
              var changeTime = stdin.readLineSync();

              if(changeTime == "ja"){

                // HTTP REQUEST
                Parking newParking = Parking(parkingId: selectedParking.parkingId, vehicleId: selectedVehicle.vehicleId, parkingSpaceId: selectedPs.parkingSpaceId, startTime: selectedParking.startTime, endTime: DateTime.now());
                await repoParking.update(selectedParking.parkingId, newParking);
                stdout.write("Parkeringen har lagts till.");
                await Future.delayed(Duration(seconds: 3));
                return;

              }else if(changeTime != "nej" && changeTime != "ja"){
                consoleUtils.invalidChoice();
              }
            }

            // HTTP REQUEST
            Parking newParking = Parking(parkingId: selectedParking.parkingId, vehicleId: selectedVehicle.vehicleId, parkingSpaceId: selectedPs.parkingSpaceId, startTime: selectedParking.startTime, endTime: selectedParking.endTime);
            await repoParking.update(selectedParking.parkingId, newParking);
            stdout.write("Parkeringen har lagts till.");
            await Future.delayed(Duration(seconds: 3));        
            return;

          }else if(psChoice == "nej"){
            continue;
          }else{
            consoleUtils.invalidChoice();
            continue;
          }

        }else if(choice == "nej"){
          continue;
        }else{
          consoleUtils.invalidChoice();
          continue;
        }
        
      }
    } else if (action == 'd') { // Lets user delete parking 

      // HTTP REQUEST
      await repoParking.delete(selectedParking.parkingId);
      stdout.write("Parkeringen är borttagen.");
      await Future.delayed(Duration(seconds: 3)); 
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}

  Future<void> endParking() async {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringar");
    stdout.writeln("Alla aktiva parkeringar i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    // HTTP REQUEST
    var parkings = await repoParking.getAll();
    var ongoingParkings = parkings.where((parking) => parking.endTime == null || parking.endTimeStatus == "pågående").toList();
    if (ongoingParkings.isEmpty) {
      stdout.writeln("Inga aktiva parkeringar finns i systemet.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
    
    for (var i = 0; i < ongoingParkings.length; i++) {
      stdout.writeln("${i + 1}. ${ongoingParkings[i]}");
    }
    
    // Lets user choose a parkings to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för den parkeringen du vill avsluta (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > ongoingParkings.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedParking = ongoingParkings[index - 1];
    stdout.writeln("Du har valt: ${selectedParking}");
    stdout.write("Vill du avsluta denna parkering? (ja/nej)");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user end parking
    if (action == 'ja') {
      while (true) {

        // HTTP REQUEST
        Parking newParking = Parking(parkingId: selectedParking.parkingId, vehicleId: selectedParking.vehicleId, parkingSpaceId: selectedParking.parkingSpaceId, startTime: selectedParking.startTime, endTime: DateTime.now());
        await repoParking.update(selectedParking.parkingId, newParking);
        stdout.write("Parkeringen har avslutats.");
        await Future.delayed(Duration(seconds: 3));    
        return;

      }
    } else if (action == 'nej') {
      return;
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}
}