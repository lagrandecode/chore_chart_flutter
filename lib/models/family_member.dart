import 'package:flutter/material.dart';

class FamilyMember {
  final String id;
  final String name;
  final Color avatarColor;
  final int points;
  final String avatarShape; // For different character types

  FamilyMember({
    required this.id,
    required this.name,
    required this.avatarColor,
    this.points = 0,
    this.avatarShape = 'circle', // circle, square, triangle
  });

  FamilyMember copyWith({
    String? id,
    String? name,
    Color? avatarColor,
    int? points,
    String? avatarShape,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarColor: avatarColor ?? this.avatarColor,
      points: points ?? this.points,
      avatarShape: avatarShape ?? this.avatarShape,
    );
  }
}

