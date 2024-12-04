import 'package:objectbox/objectbox.dart';
import 'package:shared/shared.dart';

@Entity()
class Person {
  @Id()
  int personId;

  @Index()
  @Unique()
  String ssn;

  String firstName;
  String lastName;

  Person({this.personId = 0, required this.ssn, required this.firstName, required this.lastName});

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
    
    List<String> missingFields = [];
    if (json['personId'] == null) missingFields.add('personId');
    if (json['ssn'] == null) missingFields.add('ssn');
    if (json['firstName'] == null) missingFields.add('firstName');
    if (json['lastName'] == null) missingFields.add('lastName');

    if (missingFields.isNotEmpty) {
      throw FormatException('Missing required fields: ${missingFields.join(', ')}');
    }

    return Person(
      personId: json['personId'],
      ssn: json['ssn'],
      firstName: json['firstName'],
      lastName: json['lastName']
      );
  }
}