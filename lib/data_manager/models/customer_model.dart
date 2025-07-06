// models/customer_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String customerId;
  final String name;
  final String nameLower;
  final String address;
  final String city;
  final String region;
  final List<String> nameKeywords;

  Customer({
    required this.customerId,
    required this.name,
    required this.address,
    required this.city,
    required this.region,
    required this.nameLower,
    required this.nameKeywords,

  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    customerId: json['customerId'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    city: json['city'] as String,
    region: json['region'] as String,
    nameLower: json['nameLower'] as String,
    nameKeywords: (json['nameKeywords'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),

  );

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'name': name,
    'address': address,
    'city': city,
    'region': region,
    'nameLower':    nameLower,
    'nameKeywords': nameKeywords,
  };
}
