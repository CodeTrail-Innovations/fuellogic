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
  final String? deviceToken;
  final String? companyId;
  final bool? isVerified;
  // final String? city;
  final String? companyLower;
  final List<String>? companyKeywords;

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
    this.deviceToken,
    this.companyId,
    // this.city,
    this.companyLower,
    this.companyKeywords,
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
      deviceToken: map['deviceToken'] as String?,
      companyId: map['companyId'] as String?,
      isVerified: map['isVerified'] as bool?,
      // city: map['city'] as String?,
      companyLower: map['companyLower'] as String?,
      companyKeywords: map['companyKeywords'] != null
          ? List<String>.from(map['companyKeywords'])
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
      if (deviceToken != null) 'deviceToken': deviceToken,
      if (companyId != null) 'companyId': companyId,
      // if (city != null) 'city': city,
      if (companyLower != null) 'companyLower': companyLower,
      if (companyKeywords != null) 'companyKeywords': companyKeywords,
      if (isVerified != null) 'isVerified': isVerified,
    };
  }

  /// 🔹 For JSON
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  // String toJson() => json.encode(toMap());
  String toJson() => json.encode({
    'uid': uid,
    'name': name,
    'email': email,
    'role': role,
    'createdAt': createdAt.toIso8601String(), // ✅ now serializable
    if (organization != null) 'organization': organization,
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (address != null) 'address': address,
    if (deviceToken != null) 'deviceToken': deviceToken,
    if (companyId != null) 'companyId': companyId,
    if (companyLower != null) 'companyLower': companyLower,
    if (companyKeywords != null) 'companyKeywords': companyKeywords,
    if (isVerified != null) 'isVerified': isVerified,
  });


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
    String? deviceToken,
    String? companyId,
    // String? city,
    String? companyLower,
    List<String>? companyKeywords,
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
      deviceToken: deviceToken ?? this.deviceToken,
      companyId: companyId ?? this.companyId,
      // city: city ?? this.city,
      companyLower: companyLower ?? this.companyLower,
      companyKeywords: companyKeywords ?? this.companyKeywords,
        isVerified:isVerified ?? this.isVerified
    );
  }
}
