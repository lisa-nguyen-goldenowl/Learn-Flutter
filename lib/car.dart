import 'package:flutter/material.dart';

class Car {
  String name;
  int yearOfProduction;

  Car({this.name, this.yearOfProduction});

  @override
  String toString() {
    // TODO: implement toString
    return '${this.name}, ${this.yearOfProduction}';
  }

  String sayHello(String personName) {
    return 'Hello $personName';
  }

  String sayHi({String name}) {
    return 'Hi $name';
  }

  String doSomething() {
    this.handleEvent;
    return 'I am doing Something';
  }

  Function handleEvent;
}
