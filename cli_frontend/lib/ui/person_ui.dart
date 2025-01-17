import 'package:cli_frontend/repositories/person_repository.dart';
import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/shared.dart';

import 'dart:io';

class PersonUi {
  static final PersonUi _instance = PersonUi._internal();
  PersonUi._internal();
  factory PersonUi() => _instance;

  var repoPerson = PersonRepository();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  Future<void> createNewPerson() async {
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till ny användare (Undvik å, ä, ö)\n");
      stdout.writeln("Personnr:");
      String ssn = (stdin.readLineSync() ?? "").trim();
      if (ssn.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Förnamn(utan å, ä, ö):");
      String firstName = (stdin.readLineSync() ?? "").trim();
      if (firstName.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Efternamn(utan å, ä, ö):");
      String lastName = (stdin.readLineSync() ?? "").trim();
      if (lastName.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      // HTTP REQUEST
      await repoPerson.create(Person(
          ssn: ssn,
          firstName: inputUtils.capitalizeWord(firstName),
          lastName: inputUtils.capitalizeWord(lastName)));
      stdout.write("Personen har lagts till.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
  }

  Future<void> searchPerson() async {
    while (true) {
      var personId;
      consoleUtils.clearConsole();

      personId =
          inputUtils.getValidIntWithLoop("Sök efter en person med id.\nId:");

      // HTTP REQUEST
      var person = await repoPerson.getById(personId);

      if (person == null) {
        //stdout.writeln("Personen hittades inte, vänligen försök igen.");
        await Future.delayed(Duration(seconds: 3));
        continue;
      }

      // Show person
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.writeln(person);
      stdout.writeln(
          "\n-----------------------------------------------------------\n");

      while (true) {
        stdout.writeln(
            "Välj 's' för att söka igen eller 'b' för att backa tillbaka till användarmenyn");

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

  Future<void> managePerson() async {
    var selectedPerson;

    while (true) {
      consoleUtils.clearConsole();
      stdout.writeln("\nPersoner");
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

      // Let the user choose a person to edit or delete
      stdout.writeln(
          "\n-----------------------------------------------------------\n");
      stdout.write(
          "Välj ett id för att redigera eller ta bort en person (eller 'b' för att gå tillbaka): ");

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

      stdout.write(
          "Vill du redigera (e) eller ta bort (d) denna person (eller 'b' för att gå tillbaka)? ");

      var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (action == 'b') {
        return; // Exit if the user chooses to go back
      }

      // Lets user edit person
      if (action == 'e') {
        while (true) {
          stdout.writeln("\nPersonnr:");
          String ssn = (stdin.readLineSync() ?? "").trim();
          if (ssn.isEmpty) {
            consoleUtils.invalidChoice();
            continue;
          }

          stdout.writeln("Förnamn(utan å, ä, ö):");
          String firstName = (stdin.readLineSync() ?? "").trim();
          if (firstName.isEmpty) {
            consoleUtils.invalidChoice();
            continue;
          }

          stdout.writeln("Efternamn(utan å, ä, ö):");
          String lastName = (stdin.readLineSync() ?? "").trim();
          if (lastName.isEmpty) {
            consoleUtils.invalidChoice();
            continue;
          }

          // HTTP REQUEST
          Person newPerson = Person(
              personId: selectedPerson.personId,
              ssn: ssn,
              firstName: inputUtils.capitalizeWord(firstName),
              lastName: inputUtils.capitalizeWord(lastName));
          await repoPerson.update(selectedPerson.personId, newPerson);
          stdout.write("Person uppdaterad.");
          await Future.delayed(Duration(seconds: 3));
          return;
        }
      } else if (action == 'd') { // Lets user delete person

        // HTTP REQUEST
        await repoPerson.delete(selectedPerson.personId);
        stdout.write("Person är borttagen.");
        await Future.delayed(Duration(seconds: 3));
      } else {
        consoleUtils.invalidChoice();
        continue;
      }
    }
  }
}
