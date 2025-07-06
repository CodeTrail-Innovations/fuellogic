import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final DateTime createdAt;
  final String? organization;
  final String? phoneNumber;
  final String? address;
  final bool? isVerified;
  final String? city;
  final String? nameLower;
  final List<String>? nameKeywords;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    this.organization,
    this.phoneNumber,
    this.address,
    this.isVerified,
    this.city,
    this.nameLower,
    this.nameKeywords,
  });

  /// 🔹 For Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      organization: map['organization'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      address: map['address'] as String?,
      isVerified: map['isVerified'] as bool?,
      city: map['city'] as String?,
      nameLower: map['nameLower'] as String?,
      nameKeywords: map['nameKeywords'] != null
          ? List<String>.from(map['nameKeywords'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      if (organization != null) 'organization': organization,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (nameLower != null) 'nameLower': nameLower,
      if (nameKeywords != null) 'nameKeywords': nameKeywords,
      if (isVerified != null) 'isVerified': isVerified,
    };
  }

  /// 🔹 For JSON
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  /// 🔄 Optional: CopyWith
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    DateTime? createdAt,
    String? organization,
    String? phoneNumber,
    String? address,
    String? city,
    String? nameLower,
    List<String>? nameKeywords,
    bool? isVerified
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      organization: organization ?? this.organization,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      nameLower: nameLower ?? this.nameLower,
      nameKeywords: nameKeywords ?? this.nameKeywords,
        isVerified:isVerified ?? this.isVerified
    );
  }
}
