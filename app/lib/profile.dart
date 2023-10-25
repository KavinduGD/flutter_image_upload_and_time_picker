import 'package:flutter/material.dart';

class Profile {
  String image;
  String time;

  Profile({
    required this.image,
    required this.time,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      image: json['image'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'time': time,
      };
}
