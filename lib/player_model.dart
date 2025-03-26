import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Player {
  Player(
      {required this.performance,
      required this.name,
      required this.position,
      this.id});

  late int? id;
  late double performance;
  late String name;
  late String position;

  Player copyWith(
      {int? id, String? name, double? performance, String? position}) {
    return Player(
        id: id ?? this.id,
        performance: performance ?? this.performance,
        name: name ?? this.name,
        position: position ?? this.position);
  }

  factory Player.fromJson(Map<String, dynamic> map) {
    return Player(
        id: map['id'],
        performance: map['performance'],
        name: map['name'],
        position: map['position']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'performance': performance,
      'position': position
    };
  }
}
