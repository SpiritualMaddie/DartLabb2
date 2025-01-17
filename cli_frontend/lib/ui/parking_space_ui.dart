import 'package:cli_frontend/repositories/parking_space_repository.dart';

import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/shared.dart';

import 'dart:io';


class ParkingSpaceUi {
  static final ParkingSpaceUi _instance = ParkingSpaceUi._internal();
  ParkingSpaceUi._internal();
  factory ParkingSpaceUi() => _instance;

  var repoParkingSpace = ParkingSpaceRepository();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  Future<void> createNewParkingSpace() async{
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till ny parkeringsplats (Undvik å, ä, ö)\n");  
      stdout.writeln("Zon:");
      String zone = (stdin.readLineSync() ?? "").trim();
      if (zone.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      int? pricePerHour = inputUtils.getValidIntWithLoop("Kronor per timme(ange heltal):");
      if(pricePerHour == null){
        consoleUtils.invalidChoice();
        continue;
      }
      
      // HTTP REQUEST
      await repoParkingSpace.create(ParkingSpace(zone: inputUtils.capitalizeWord(zone), pricePerHour: pricePerHour));
      stdout.write("Parkeringsplatsen har lagts till.");
      await Future.delayed(Duration(seconds: 3));    
      return;    
    }  
}

  Future<void> searchParkingSpace() async {
    while (true) {
      var parkingSpaceId;
      consoleUtils.clearConsole();

      parkingSpaceId =
          inputUtils.getValidIntWithLoop("Sök efter en parkingsplats med id.\nId:");

      // HTTP REQUEST
      var parkingSpace = await repoParkingSpace.getById(parkingSpaceId);

      if (parkingSpace == null) {
        //stdout.writeln("Parkingsplatsen hittades inte, vänligen försök igen.");
        await Future.delayed(Duration(seconds: 3));
        continue;
      }

      // Show parking space
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.writeln(parkingSpace);
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      while (true) {
        stdout.writeln(
            "Välj 's' för att söka igen eller 'b' för att backa tillbaka till parkingsplatsmenyn");

        var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if (action == 's') {
          break;
        } else if (action == 'b') {
          return;
        } else {
          stdout.writeln("Felaktigt val, försök igen");
          await Future.delayed(Duration(seconds: 2));
        }
      }
    }
  }

Future<void> manageParkingSpace() async {
  var parkingSpaces;
  var selectedPs;

  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringsplatser");
    stdout.writeln("Alla platser i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    // HTTP REQUEST
    parkingSpaces = await repoParkingSpace.getAll();
    if (parkingSpaces.isEmpty) {
      stdout.writeln("Inga parkingsplatser finns i systemet.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }

    for (var i = 0; i < parkingSpaces.length; i++) {
      stdout.writeln("${parkingSpaces[i]}");
    }
    
    // Lets user choose a parkingspace to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett id för att redigera eller ta bort en parkeringsplats (eller 'b' för att gå tillbaka):\n");
    
      while (true) {
        var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if (input == 'b') {
          return; // Exit if the user chooses to go back
        }

        // Validate if input is an integer
        int? index = inputUtils.getValidInt(input);
        if (index == null) {
          continue; // Loop until a valid integer is entered
        }

        // Get the selected parking space and check if they exist
        selectedPs = await repoParkingSpace.getById(index);
        if (selectedPs == null) {
          //stdout.writeln("Parkingsplatsen hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If parking space is valid
        consoleUtils.clearConsole();
        stdout.writeln("Vald parkingsplats:\n$selectedPs");
        break; // Exit the loop once a valid parking space is selected
      }

    stdout.write("Vill du redigera (e) eller ta bort (d) denna plats (eller 'b' för att gå tillbaka)? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

    if (action == 'b') {
      return; // Exit if the user chooses to go back
    }

    // Lets user edit space
    if (action == 'e') {
      while (true) {
          
        stdout.writeln("\nZone(utan å, ä, ö):");
        String zone = (stdin.readLineSync() ?? "").trim();
        if (zone.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }

        int? pricePerHour = inputUtils.getValidIntWithLoop("Pris per timme(ange heltal):");
        if(pricePerHour == null){
          consoleUtils.invalidChoice();
          continue;
        }

        // HTTP REQUEST
        ParkingSpace newParkingSpace = ParkingSpace(parkingSpaceId: selectedPs.parkingSpaceId, zone: zone, pricePerHour: pricePerHour);
        await repoParkingSpace.update(selectedPs.parkingSpaceId, newParkingSpace);
        stdout.write("Parkeringsplats uppdaterad.");
        await Future.delayed(Duration(seconds: 3));        
        return;
      }
    } else if (action == 'd') { // Lets user delete space 

      // HTTP REQUEST
      await repoParkingSpace.delete(selectedPs.parkingSpaceId);
      stdout.write("Parkeringsplats är borttagen.");
      await Future.delayed(Duration(seconds: 3)); 
      return;
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}
}