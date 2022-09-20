import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Pokemon {
  String name;
  String urlPic;
  int height;
  int weight;
  List<String> types;

  Pokemon(
      {required this.name,
      required this.urlPic,
      required this.height,
      required this.weight,
      required this.types}) {}
}
