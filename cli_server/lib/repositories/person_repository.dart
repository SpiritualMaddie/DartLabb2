import 'package:shared/interfaces/respository_interface.dart';
import 'package:shared/models/person.dart';

class PersonRepository implements RepositoryInterface<Person>{

  static final PersonRepository _instance = PersonRepository._internal();

  PersonRepository._internal();

  factory PersonRepository() => _instance;
  
  @override
  Future<Person> create(Person person) {
    // TODO: implement create
    throw UnimplementedError();
  }
  
  @override
  Future<Person> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<Person>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
  
  @override
  Future<Person?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  @override
  Future<Person> update(int id, Person person) {
    // TODO: implement update
    throw UnimplementedError();
  }

  }