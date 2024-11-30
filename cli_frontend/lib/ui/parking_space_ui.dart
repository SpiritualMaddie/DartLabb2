import 'package:cli_frontend/repositories/parking_space_repository.dart';

import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/models/parking_space.dart';

import 'package:http/http.dart' as http;
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

      int? pricePerHour = inputUtils.getValidIntPrice("Pris per timme(ange heltal):");
      if(pricePerHour == null){
        consoleUtils.invalidChoice();
        continue;
      }

      int? parkingSpaceId = inputUtils.getValidIntPrice("Parkingsplatsid (heltal tresiffrigt, börjar med 3 (tex 311)):");
      if(parkingSpaceId == null){
        consoleUtils.invalidChoice();
        continue;
      }
      
      // HTTP REQUEST
      await repoParkingSpace.create(ParkingSpace(parkingSpaceId: parkingSpaceId, zone: inputUtils.capitalizeWord(zone), pricePerHour: pricePerHour));
      stdout.write("Parkeringsplatsen har lagts till.");
      await Future.delayed(Duration(seconds: 3));    
      return;    
    }  
}

Future<void> manageParkingSpace() async {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringsplatser");
    stdout.writeln("Alla platser i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    // HTTP REQUEST
    var parkingSpaces;
    try{

      parkingSpaces = await repoParkingSpace.getAll();

    }catch(error){
      stdout.writeln("Unable to fetch due to error: ${error}");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
    if (parkingSpaces.isEmpty) {
      stdout.writeln("Inga parkeringsplatser finns i systemet.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
    
    for (var i = 0; i < parkingSpaces.length; i++) {
      stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
    }
    
    // Lets user choose a parkingspace to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en parkeringsplats (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkingspace exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkingSpaces.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    ParkingSpace selectedPs = parkingSpaces[index - 1];
    stdout.writeln("Du har valt:\n ${selectedPs}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna plats? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit space
    if (action == 'e') {
      while (true) {
          
        stdout.writeln("\nZone(utan å, ä, ö):");
        String zone = (stdin.readLineSync() ?? "").trim();
        if (zone.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }

        int? pricePerHour = inputUtils.getValidIntPrice("Pris per timme(ange heltal):");
        if(pricePerHour == null){
          consoleUtils.invalidChoice();
          continue;
        }
        
        // int? parkingSpaceId = inputUtils.getValidIntPrice("Parkingsplatsid (heltal tresiffrigt, börjar med 3 (tex 311)) \n använd samma som sist:");
        // if(parkingSpaceId == null){
        //   consoleUtils.invalidChoice();
        //   continue;
        // }

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