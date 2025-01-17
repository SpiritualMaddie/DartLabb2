import 'package:cli_frontend/repositories/person_repository.dart';
import 'package:cli_frontend/repositories/vehicle_repository.dart';

import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';
import 'package:cli_frontend/ui/person_ui.dart';

import 'package:shared/shared.dart';

import 'dart:io';

class VehicleUi {
  static final VehicleUi _instance = VehicleUi._internal();
  VehicleUi._internal();
  factory VehicleUi() => _instance;

  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var personUi = PersonUi();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  Future<void> createNewVehicle() async {
    var selectedPerson;

    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till nytt fordon (Undvik å, ä, ö)\n");
      stdout.writeln("Regnummer:");
      String licensePlate = (stdin.readLineSync() ?? "").trim();
      if (licensePlate.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Fordonstyp(utan å, ä, ö):");
      String vehicleType = (stdin.readLineSync() ?? "").trim();
      if (vehicleType.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Alla personer i systemet:");
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      // HTTP REQUEST
      var persons = await repoPerson.getAll();
      if (persons.isEmpty) {
        stdout.writeln("Inga personer finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }

      for (var i = 0; i < persons.length; i++) {
        stdout.writeln("${persons[i]}");
      }

      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för att välja en person som ägare (eller 'b' för att gå tillbaka):\n");

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

        // Get the selected person and check if they exist
        selectedPerson = await repoPerson.getById(index);
        if (selectedPerson == null) {
          //stdout.writeln("Personen hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If person is valid
        consoleUtils.clearConsole();
        stdout.writeln("Vald person:\n$selectedPerson");
        break; // Exit the loop once a valid person is selected
      }

      stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      if (choice == 'ja') {
        // HTTP REQUEST
        await repoVehicle.create(Vehicle(
            licensePlate: licensePlate.toUpperCase(),
            vehicleType: inputUtils.capitalizeWord(vehicleType),
            personId: selectedPerson.personId));
        stdout.write("Fordonet har lagts till.");
        await Future.delayed(Duration(seconds: 3));
        return manageVehicle();
      } else if (choice == "nej") {
        createNewVehicle();
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }

  Future<void> searchVehicle() async {
    while (true) {
      var vehicleId;
      consoleUtils.clearConsole();

      vehicleId =
          inputUtils.getValidIntWithLoop("Sök efter ett fordon med id.\nId:");

      // HTTP REQUEST
      var vehicle = await repoVehicle.getById(vehicleId);

      if (vehicle == null) {
        //stdout.writeln("Fordonet hittades inte, vänligen försök igen.");
        await Future.delayed(Duration(seconds: 3));
        continue;
      }

      // Show Vehicle
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.writeln(vehicle);
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      while (true) {
        stdout.writeln(
            "Välj 's' för att söka igen eller 'b' för att backa tillbaka till fordonsmenyn");

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

  Future<void> manageVehicle() async {
    var selectedVehicle;
    var selectedPerson;
    while (true) {
      consoleUtils.clearConsole();
      stdout.writeln("\nFordon");
      stdout.writeln("Alla fordon i systemet:");
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      // HTTP REQUEST
      var vehicles = await repoVehicle.getAll();
      if (vehicles.isEmpty) {
        stdout.writeln("Inga fordon finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }

      for (var i = 0; i < vehicles.length; i++) {
        stdout.writeln("${vehicles[i]}");
      }

      // Lets user choose a vehicle to edit or delete
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för att redigera eller ta bort ett fordon (eller 'b' för att gå tillbaka): ");

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

        // Get the selected vehicle and check if they exist
        selectedVehicle = await repoVehicle.getById(index);
        if (selectedVehicle == null) {
          //stdout.writeln("Fordonet hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If vehicle is valid
        consoleUtils.clearConsole();
        stdout.writeln("Valt fordon:\n$selectedVehicle");
        break; // Exit the loop once a valid vehicle is selected
      }

      stdout.write("Vill du redigera (e) eller ta bort (d) detta fordon (eller 'b' för att gå tillbaka)? ");

      var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (action == 'b') {
        return; // Exit if the user chooses to go back
      }

      // Lets user edit vehicle
      if (action == 'e') {
        while (true) {
          stdout.writeln("\nRegnr:");
          String licensePlate = (stdin.readLineSync() ?? "").trim();
          if (licensePlate.isEmpty) {
            consoleUtils.invalidChoice();
            continue;
          }

          stdout.writeln("Fordonstyp(utan å, ä, ö):");
          String vehicleType = (stdin.readLineSync() ?? "").trim();
          if (vehicleType.isEmpty) {
            consoleUtils.invalidChoice();
            continue;
          }

          stdout.writeln("\nAlla personer i systemet:");
          stdout.writeln(
              "\n-----------------------------------------------------------\n");

          // HTTP REQUEST
          var persons = await repoPerson.getAll();
          if (persons.isEmpty) {
            stdout.writeln(
                "Det finns inga personer i systemet att välja som ägare. Lägg till en person först");
            await Future.delayed(Duration(seconds: 4));
            return;
          }

          for (var i = 0; i < persons.length; i++) {
            stdout.writeln("${persons[i]}");
          }

          stdout.writeln(
              "\n-----------------------------------------------------------\n");
          stdout.write(
              "Välj ett id på en person för att välja denne som ägare (eller 'b' för att gå tillbaka): ");

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

        // Get the selected person and check if they exist
        selectedPerson = await repoPerson.getById(index);
        if (selectedPerson == null) {
          //stdout.writeln("Personen hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If person is valid
        consoleUtils.clearConsole();
        stdout.writeln("Vald person:\n$selectedPerson");
        break; // Exit the loop once a valid person is selected
      }

          stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

          var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
          if (choice == 'ja') {
            // HTTP REQUEST
            Vehicle newVehicle = Vehicle(
                vehicleId: selectedVehicle.vehicleId,
                licensePlate: licensePlate.toUpperCase(),
                vehicleType: inputUtils.capitalizeWord(vehicleType),
                personId: selectedPerson.personId);
            await repoVehicle.update(selectedVehicle.vehicleId, newVehicle);
            stdout.write("Fordon uppdaterad.");
            await Future.delayed(Duration(seconds: 3));
            return manageVehicle();
          } else if (choice == "nej") {
            continue;
          } else {
            stdout.writeln("Ogiltigt val.");
            await Future.delayed(Duration(seconds: 2));
            continue;
          }
        }
      } else if (action == 'd') { // Lets user delete person

        // HTTP REQUEST
        await repoVehicle.delete(selectedVehicle.vehicleId);
        stdout.write("Fordonet är borttaget.");
        await Future.delayed(Duration(seconds: 3));
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }
}
