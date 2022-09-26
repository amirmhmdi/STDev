import 'package:flutter/material.dart';

Color chooseColor(String name) {
  Color pickedColor = Colors.blue;
  switch (name.substring(0, 1).toUpperCase()) {
    case "A":
      pickedColor = Colors.red;
      break;
    case "B":
      pickedColor = Colors.deepPurple;
      break;
    case "C":
      pickedColor = Colors.amber;
      break;
    case "D":
      pickedColor = Colors.amberAccent;
      break;
    case "E":
      pickedColor = Colors.blue;
      break;
    case "F":
      pickedColor = Colors.blueAccent;
      break;
    case "G":
      pickedColor = Colors.blueGrey;
      break;
    case "H":
      pickedColor = Colors.brown;
      break;
    case "I":
      pickedColor = Colors.deepOrange;
      break;
    case "J":
      pickedColor = Colors.orangeAccent;
      break;
    case "K":
      pickedColor = Colors.orange;
      break;
    case "L":
      pickedColor = Colors.green;
      break;
    case "M":
      pickedColor = Colors.purple;
      break;
    case "N":
      pickedColor = Colors.pink;
      break;
    case "O":
      pickedColor = Colors.red;
      break;
    case "P":
      pickedColor = Colors.yellow;
      break;
    case "Q":
      pickedColor = Colors.teal;
      break;
    case "R":
      pickedColor = Colors.purpleAccent;
      break;
    case "Z":
      pickedColor = Colors.yellowAccent;
      break;
    default:
      pickedColor = Colors.blue;
  }
  return pickedColor;
}
