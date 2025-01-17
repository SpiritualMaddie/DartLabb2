import 'package:cli_frontend/repositories/parking_repository.dart';
import 'package:cli_frontend/repositories/parking_space_repository.dart';
import 'package:cli_frontend/repositories/vehicle_repository.dart';

import 'package:cli_frontend/ui/parking_space_ui.dart';
import 'package:cli_frontend/ui/vehicle_ui.dart';
import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/shared.dart';

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

  Future<void> createNewParking() async {
    var selectedVehicle;
    var selectedParkingSpace;

    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till en ny parkering\n");

      stdout.writeln("Alla fordon i systemet:");
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      var vehicles = await repoVehicle.getAll();
      if (vehicles.isEmpty) {
        stdout.writeln("Inga fordon finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }

      for (var i = 0; i < vehicles.length; i++) {
        stdout.writeln("${vehicles[i]}");
      }

      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för att välja ett fordon att parkera (eller 'b' för att gå tillbaka): ");

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

      stdout.writeln("Vill du parkera detta fordon? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (choice == "nej") {
        return; // Exit edit
      } else if (choice == 'ja') {
        stdout.writeln("Alla parkeringsplatser i systemet:");
        stdout.writeln(
            "\n-----------------------------------------------------------\n");

        var parkingSpaces = await repoParkingSpace.getAll();
        if (parkingSpaces.isEmpty) {
          stdout.writeln("Inga parkeringsplatser finns i systemet.");
          await Future.delayed(Duration(seconds: 3));
          return;
        }

        for (var i = 0; i < parkingSpaces.length; i++) {
          stdout.writeln("${parkingSpaces[i]}");
        }

        stdout.writeln(
            "\n-----------------------------------------------------------\n");
        stdout.write(
            "Välj ett id för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");

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
          selectedParkingSpace = await repoParkingSpace.getById(index);
          if (selectedParkingSpace == null) {
            //stdout.writeln("Parkeringsplatsen hittades inte, vänligen försök igen.");
            await Future.delayed(Duration(seconds: 3));
            continue; // Loop again
          }

          // If parking space is valid
          consoleUtils.clearConsole();
          stdout.writeln("Vald parkeringplats:\n$selectedParkingSpace");
          break; // Exit the loop once a valid parking space is selected
        }

        stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

        var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if (psChoice == "ja") {
          // HTTP REQUEST
          await repoParking.create(Parking(
              vehicleId: selectedVehicle.vehicleId,
              parkingSpaceId: selectedParkingSpace.parkingSpaceId,
              startTime: DateTime.now()));

          stdout.write("Parkeringen har lagts till.");
          await Future.delayed(Duration(seconds: 3));
          return;
        } else if (psChoice == "nej") {
          return;
        } else {
          consoleUtils.invalidChoice();
          continue;
        }
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }

  Future<void> searchParking() async {
    while (true) {
      var parkingId;
      consoleUtils.clearConsole();

      parkingId =
          inputUtils.getValidIntWithLoop("Sök efter en parking med id.\nId:");

      // HTTP REQUEST
      var parking = await repoParking.getById(parkingId);

      if (parking == null) {
        await Future.delayed(Duration(seconds: 3));
        continue; // User gets sent back to start of while loop
      }

      // Get Vehicle and ParkingSpace objects if parking is not null (a parking always has these values)
      var parkingSpace = await repoParkingSpace.getById(parking.parkingSpaceId);
      var vehicle = await repoVehicle.getById(parking.vehicleId);

      // Show parking
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.writeln(parking.toDetailedString(vehicle!, parkingSpace!));
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      while (true) {
        stdout.writeln(
            "Välj 's' för att söka igen eller 'b' för att backa tillbaka till parkeringsmenyn");

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

  Future<void> manageParking() async {
    var selectedParking;
    var selectedVehicle;
    var selectedParkingSpace;

    while (true) {
      consoleUtils.clearConsole();
      stdout.writeln("\nParkeringar");
      stdout.writeln("Alla parkeringar i systemet:");
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      // HTTP REQUEST
      var parkings = await repoParking.getAll();
      if (parkings.isEmpty) {
        stdout.writeln("Inga parkeringar finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }

      for (var i = 0; i < parkings.length; i++) {
        stdout.writeln("${parkings[i]}");
      }

      // Lets user choose a parkings to edit or delete
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för att se fler detaljer, redigera eller ta bort en parkering (eller 'b' för att gå tillbaka): ");

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

        // Get the selected parking and check if they exist
        selectedParking = await repoParking.getById(index);
        if (selectedParking == null) {
          //stdout.writeln("Parkeringen hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If parking is valid
        consoleUtils.clearConsole();
        // Get Vehicle and ParkingSpace objects if parking is not null (a parking always has these values)
        var parkingSpace = await repoParkingSpace.getById(selectedParking.parkingSpaceId);
        var vehicle = await repoVehicle.getById(selectedParking.vehicleId);
        stdout.writeln("Vald parkering:\n${selectedParking.toDetailedString(vehicle!, parkingSpace!)}");
        break; // Exit the loop once a valid parking is selected
      }

      stdout.write(
          "Vill du redigera (e) eller ta bort (d) denna parkering?\n(eller 'b' för att gå tillbaka)\n");

      var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (action == "b") {
        // Lets user go back
        return;
      } else if (action == "d") {
        // Lets user delete parking

        // HTTP REQUEST
        await repoParking.delete(selectedParking.parkingId);
        stdout.write("Parkeringen är borttagen.");
        await Future.delayed(Duration(seconds: 3));
        return;
      } else if (action == 'e') {
        // Lets user edit parking
        while (true) {
          // Shows all vehicles to choose from
          stdout.writeln("Alla fordon i systemet:");
          stdout.writeln(
              "\n-----------------------------------------------------------\n");

          var vehicles = await repoVehicle.getAll();
          if (vehicles.isEmpty) {
            stdout.writeln("Inga fordon finns i systemet.");
            await Future.delayed(Duration(seconds: 3));
            return;
          }

          for (var i = 0; i < vehicles.length; i++) {
            stdout.writeln("${vehicles[i]}");
          }

          stdout.writeln(
              "\n-----------------------------------------------------------\n");
          stdout.write(
              "Välj ett id för att välja ett fordon (eller 'b' för att gå tillbaka): ");

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

          stdout.writeln("Vill du ha detta fordon i din parkering? (ja/nej)");

          var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

          if (choice == "nej") {
            return; // Exit edit
          } else if (choice == 'ja') {
            stdout.writeln("Alla parkeringsplatser i systemet:");
            stdout.writeln(
                "\n-----------------------------------------------------------\n");

            // HTTP REQUEST
            var parkingSpaces = await repoParkingSpace.getAll();
            if (parkingSpaces.isEmpty) {
              stdout.writeln("Inga parkeringsplatser finns i systemet.");
              await Future.delayed(Duration(seconds: 3));
              return;
            }

            for (var i = 0; i < parkingSpaces.length; i++) {
              stdout.writeln("${parkingSpaces[i]}");
            }

            stdout.writeln(
                "\n-----------------------------------------------------------\n");
            stdout.write(
                "Välj ett id för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");

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
              selectedParkingSpace = await repoParkingSpace.getById(index);
              if (selectedParkingSpace == null) {
                //stdout.writeln("Parkeringsplatsen hittades inte, vänligen försök igen.");
                await Future.delayed(Duration(seconds: 3));
                continue; // Loop again
              }

              // If parking space is valid
              consoleUtils.clearConsole();
              stdout.writeln("Vald parkeringplats:\n$selectedParkingSpace");
              break; // Exit the loop once a valid parking space is selected
            }

            stdout.writeln("Vill du ha parkeringen på denna plats? (ja/nej)");

            var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

            if (psChoice == "nej") {
              return; // Exit edit
            } else if (psChoice == "ja") {
              if (selectedParking.endTimeStatus == "pågående") {
                stdout.writeln(
                    "Vill du ändra sluttiden från 'pågående' till 'avslutad'? (ja/nej)");
                var changeTime = stdin.readLineSync();

                if (changeTime == "ja") {
                  // HTTP REQUEST
                  Parking newParking = Parking(
                      parkingId: selectedParking.parkingId,
                      vehicleId: selectedVehicle.vehicleId,
                      parkingSpaceId: selectedParkingSpace.parkingSpaceId,
                      startTime: selectedParking.startTime,
                      endTime: DateTime.now());

                  await repoParking.update(
                      selectedParking.parkingId, newParking);
                  stdout.write("Parkeringen har uppdaterats.");
                  await Future.delayed(Duration(seconds: 3));
                  return;
                } else if (changeTime != "nej" && changeTime != "ja") {
                  consoleUtils.invalidChoice();
                }
              }

              // HTTP REQUEST
              Parking newParking = Parking(
                  parkingId: selectedParking.parkingId,
                  vehicleId: selectedVehicle.vehicleId,
                  parkingSpaceId: selectedParkingSpace.parkingSpaceId,
                  startTime: selectedParking.startTime,
                  endTime: selectedParking.endTime);

              await repoParking.update(selectedParking.parkingId, newParking);
              stdout.write("Parkeringen har uppdaterats.");
              await Future.delayed(Duration(seconds: 3));
              return;
            } else {
              consoleUtils.invalidChoice();
              continue;
            }
          } else {
            consoleUtils.invalidChoice();
            continue;
          }
        }
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }

  Future<void> endParking() async {
    var selectedParking;

    while (true) {
      consoleUtils.clearConsole();
      stdout.writeln("\nParkeringar");
      stdout.writeln("Alla aktiva parkeringar i systemet:");
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      // HTTP REQUEST
      var parkings = await repoParking.getAll();
      var ongoingParkings = parkings
          .where((parking) =>
              parking.endTime == null || parking.endTimeStatus == "pågående")
          .toList();
      if (ongoingParkings.isEmpty) {
        stdout.writeln("Inga aktiva parkeringar finns i systemet.");
        await Future.delayed(Duration(seconds: 3));
        return;
      }

      for (var i = 0; i < ongoingParkings.length; i++) {
        stdout.writeln("${ongoingParkings[i]}");
      }

      // Lets user choose a parkings to edit or delete
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för den parkeringen du vill se mer detaljer om och avsluta (eller 'b' för att gå tillbaka): ");

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

        // Get the selected parking and check if they exist
        selectedParking = await repoParking.getById(index);
        if (selectedParking == null) {
          //stdout.writeln("Parkeringen hittades inte, vänligen försök igen.");
          await Future.delayed(Duration(seconds: 3));
          continue; // Loop again
        }

        // If parking is valid
        consoleUtils.clearConsole();
        // Get Vehicle and ParkingSpace objects if parking is not null (a parking always has these values)
        var parkingSpace = await repoParkingSpace.getById(selectedParking.parkingSpaceId);
        var vehicle = await repoVehicle.getById(selectedParking.vehicleId);
        stdout.writeln("Vald parkering:\n${selectedParking.toDetailedString(vehicle!, parkingSpace!)}");
        break; // Exit the loop once a valid parking is selected
      }

      stdout.write("Vill du avsluta denna parkering? (ja/nej)");

      var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (action == "nej") {
        // Lets user go back
        return;
      } else if (action == 'ja') {
        // Lets user end parking
        while (true) {
          // HTTP REQUEST
          Parking newParking = Parking(
              parkingId: selectedParking.parkingId,
              vehicleId: selectedParking.vehicleId,
              parkingSpaceId: selectedParking.parkingSpaceId,
              startTime: selectedParking.startTime,
              endTime: DateTime.now());

          await repoParking.update(selectedParking.parkingId, newParking);
          stdout.write("Parkeringen har avslutats.");
          await Future.delayed(Duration(seconds: 3));
          return;
        }
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }
}
