import 'package:cli_server/server_config.dart';
import 'package:shared/shared.dart';

class PersonRepository implements RepositoryInterface<Person>{

  static final PersonRepository _instance = PersonRepository._internal();

  PersonRepository._internal();

  factory PersonRepository() => _instance;

  Box<Person> personBox = ServerConfig.instance.store.box<Person>();
  
  @override
  Future<Person?> create(Person person) async {
    
    personBox.put(person, mode:PutMode.insert);

    return person;
  }
  
  @override
  Future<Person?> delete(int id) async {
    Person? person = personBox.get(id);

    if(person != null){
      personBox.remove(id);
    }

    return person;
  }
  
  @override
  Future<List<Person>> getAll() async {
    
    return personBox.getAll();
  }
  
  @override
  Future<Person?> getById(int id) async {
    return personBox.get(id);
  }
  
  @override
  Future<Person?> update(int id, Person newPerson) async {
    personBox.put(newPerson, mode: PutMode.update);
    return newPerson;
  }
}