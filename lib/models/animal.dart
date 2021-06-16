import 'package:flutter/material.dart';

class Animal {
  // ignore: non_constant_identifier_names
  final String label;
  // ignore: non_constant_identifier_names
  final String Time;
  // final String description;
  // final double price;
  final String image;
  // final bool isFavorite;
  // final String userEmail;
  final String animalId;

  Animal({
    // ignore: non_constant_identifier_names
    @required this.label,
    // ignore: non_constant_identifier_names
    @required this.Time,
    // @required this.description,
    // @required this.price,
    @required this.image,
    // this.isFavorite = false,
    // @required this.userEmail,
    @required this.animalId,
  });
}
