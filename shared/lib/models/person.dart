import 'dart:convert';
import 'dart:io';

class Person {
  int personId;
  String ssn;
  String firstName;
  String lastName;

  Person({required this.personId, required this.ssn, required this.firstName, required this.lastName});

  @override
  String toString() {
    return """
Namn: $firstName $lastName
   Personnr: $ssn
   Id: $personId
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
  'personId' : personId,
  'ssn' : ssn,
  'firstName' : firstName,
  'lastName' : lastName
  };

  // Deserialization
  factory Person.fromJson(Map<String, dynamic> json){

    
    if(json['personId'] == null || json['ssn'] == null || json['firstName'] == null || json['lastName'] == null){
      throw FormatException('Missing required fields: personId, ssn, firstName or lastName');
    }
    print('in fromJson after if');
    print(json);

    return Person(
      personId: json['personId'],
      ssn: json['ssn'],
      firstName: json['firstName'],
      lastName: json['lastName']
      );
  }
}