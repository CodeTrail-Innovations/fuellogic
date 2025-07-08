import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuellogic/core/enums/enum.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final Timestamp createdAt;
  final UserRole role;
  final String companyId;
  final List<Map<String, dynamic>>? driver;
  final bool isVerified;
  final String phoneNumber;
  final String address;

  static const UserRole defaultRole = UserRole.driver;
  static final Timestamp defaultCreatedAt =
      Timestamp.fromMillisecondsSinceEpoch(1704067200000);
  static const bool defaultIsVerified = false;

  UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.photoURL = '',
    this.companyId = '',
    this.role = defaultRole,
    this.driver,
    this.isVerified = defaultIsVerified,
    this.phoneNumber = '',
    this.address = '',
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? defaultCreatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      displayName: json['displayName']?.toString() ?? '',
      companyId: json['companyId']?.toString() ?? '',
      photoURL: json['photoURL']?.toString() ?? '',
      createdAt: json['createdAt'] as Timestamp? ?? defaultCreatedAt,
      role: _parseUserRole(json['role']),
      driver: _parseDriverList(json['driver']),
      isVerified: json['isVerified'] as bool? ?? defaultIsVerified,
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'companyId': companyId,
    'photoURL': photoURL,
    'createdAt': createdAt,
    'role': role.value,
    'isVerified': isVerified,
    'phoneNumber': phoneNumber,
    'address': address,
    if (driver != null) 'driver': driver,
  };

  static UserRole _parseUserRole(dynamic roleValue) {
    try {
      return UserRole.fromValue(roleValue?.toString() ?? '');
    } catch (e) {
      return defaultRole;
    }
  }

  static List<Map<String, dynamic>>? _parseDriverList(dynamic driverValue) {
    if (driverValue == null) return null;
    if (driverValue is List) {
      return driverValue
          .whereType<Map<String, dynamic>>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return null;
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    Timestamp? createdAt,
    UserRole? role,
    String? companyId,
    List<Map<String, dynamic>>? driver,
    bool? isVerified,
    String? phoneNumber,
    String? address,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
      companyId: companyId ?? this.companyId,
      driver: driver ?? this.driver,
      isVerified: isVerified ?? this.isVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, '
        'photoURL: $photoURL, createdAt: $createdAt, role: ${role.label}, '
        'companyId: $companyId, driver: $driver, isVerified: $isVerified, '
        'phoneNumber: $phoneNumber,  address: $address)';
  }
}
