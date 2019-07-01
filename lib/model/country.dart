import 'package:flutter/material.dart';

class Country {
  String name;
  String emoji;
  String nativeName;
  String currency;
  String phone;
  String languages;

  Country({
    @required this.name,
    @required this.emoji,
    @required this.nativeName,
    @required this.currency,
    @required this.phone,
    @required this.languages,
  });

  static Country fromMap(dynamic data) {
    return Country(
      name: data['name'],
      emoji: data['emoji'],
      nativeName: data['native'],
      currency: data['currency'],
      phone: data['phone'],
      languages:
          data['languages'].map((lang) => lang['name']).toList().join(', '),
    );
  }
}
