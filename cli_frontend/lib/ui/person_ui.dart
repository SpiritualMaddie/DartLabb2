import 'dart:convert';

import 'package:cli_frontend/repositories/person_repository.dart';
import 'package:cli_frontend/utils/console_utils.dart';
import 'package:cli_frontend/utils/input_utils.dart';

import 'package:shared/models/person.dart';

import 'package:http/http.dart' as http;
import 'dart:io';


class PersonUi {
  static final PersonUi _instance = PersonUi._internal();
  PersonUi._internal();
  factory PersonUi() => _instance;


  var repoPerson = PersonRepository();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  Future<void> addNewPerson() async {

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

      int? personId = inputUtils.getValidIntPrice("Personid (heltal tresiffrigt, börjar med 1 (tex 111)):");
      if(personId == null){
        consoleUtils.invalidChoice();
        continue;
      }
      
      // HTTP REQUEST
      await repoPerson.create(Person(personId: personId, ssn: ssn, firstName: inputUtils.capitalizeWord(firstName), lastName: inputUtils.capitalizeWord(lastName)));
      stdout.write("Personen har lagts till.");
      await Future.delayed(Duration(seconds: 3));        
      return;
    }  
}

Future<void> managePerson() async {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nPersoner");
    stdout.writeln("Alla personer i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    // HTTP REQUEST

    var persons = await repoPerson.getAll();
    // Error handling to read errors
    stdin.readLineSync();
    if (persons.isEmpty) {
      stdout.writeln("Inga personer finns i systemet.");
      await Future.delayed(Duration(seconds: 3));
      return;
    }
    
    for (var i = 0; i < persons.length; i++) {
      stdout.writeln("${i + 1}. ${persons[i]}");
    }
    
    // Lets user choose a person to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en person (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if person exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > persons.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedPerson = persons[index - 1];
    stdout.writeln("Du har valt: ${selectedPerson}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna person? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
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

        // int? personId = inputUtils.getValidIntPrice("Personid (heltal tresiffrigt, börjar med 1 (tex 111)) \n använd samma som sist:");
        // if(personId == null){
        //   consoleUtils.invalidChoice();
        //   continue;
        // }
        
        // HTTP REQUEST
        Person newPerson = Person(personId: selectedPerson.personId, ssn: ssn, firstName: inputUtils.capitalizeWord(firstName), lastName: inputUtils.capitalizeWord(lastName));
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