import 'package:cli_frontend/utils/console_utils.dart';

import 'dart:io';

class InputUtils {
  var consoleUtils = ConsoleUtils();
  
  String capitalizeWord(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

// Validating input as int returning null unless correct
  int? getValidInt(String input) {
    if (input.isEmpty) {
      stdout.writeln("Ops, du måste skriva något.");
      return null;
    }

    try {
      int valueInt = int.parse(input);
      if (valueInt < 1) {
        stdout.writeln("Siffran kan inte vara noll eller negativt. Försök igen.");
        return null;
      }
      return valueInt;
    } on FormatException {
      stdout.writeln("Ogiltigt värde. Ange ett heltal.");
      return null;
    }
  }

// Validating input as int looping unless correct
  int? getValidIntWithLoop(String prompt) {
    while (true) {
      stdout.writeln(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";

      if (input.isEmpty) {
        stdout.writeln("Ops, du måste skriva något.");
        continue;
      }

      try {
        int valueInt = int.parse(input);
        if (valueInt < 1) {
          stdout.writeln("Siffran kan inte vara noll eller negativt. Försök igen.");
          continue;
        }
        return valueInt;
      } on FormatException {
        stdout.writeln("Ogiltigt värde. Ange ett heltal.");
      }
    }
  }

  // Future<void> getSelectedObject(Object repo) async{
  //       while (true) {
  //       var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
  //
  //       if (input == 'b') {
  //         return; // Exit if the user chooses to go back
  //       }
  //
  //       // Validate if input is an integer
  //       int? index = getValidInt(input);
  //       if (index == null) {
  //         continue; // Loop until a valid integer is entered
  //       }
  //
  //       // Get the selected vehicle and check if they exist
  //       var selectedvehicle = await repo.getById(index);
  //       if (selectedvehicle == null) {
  //         //stdout.writeln("Fordonet hittades inte, vänligen försök igen.");
  //         await Future.delayed(Duration(seconds: 3));
  //         continue; // Loop again
  //       }
  //
  //       // If vehicle is valid
  //       consoleUtils.clearConsole();
  //       stdout.writeln("Valt fordon:\n$selectedvehicle");
  //       break; // Exit the loop once a valid vehicle is selected
  //     }
  // }

}
