

class Person {
  //int personId;
  String ssn;
  String firstName;
  String lastName;

  Person({required this.ssn, required this.firstName, required this.lastName});

  @override
  String toString() {
    return """
Namn: $firstName $lastName
   Personnr: $ssn
-----------------------------------------------------------""";
  }

  // Serialization
  Map<String, dynamic> toJson() => {
  'ssn' : ssn,
  'firstname' : firstName,
  'lastname' : lastName
  };

  // Deserialization
  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
      ssn: json['ssn'],
      firstName: json['firstName'],
      lastName: json['lastName']
      );
  }
}