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

  static final Timestamp defaultCreatedAt =
      Timestamp.fromMillisecondsSinceEpoch(1704067200000);

  UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.photoURL = '',
    this.companyId = '',
    this.role = UserRole.driver,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? defaultCreatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      companyId: json['companyId'] ?? '',
      photoURL: json['photoURL'] ?? '',
      createdAt: json['createdAt'] as Timestamp? ?? defaultCreatedAt,
      role: UserRoleExtension.fromApi(json['role'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'companyId': companyId,
      'photoURL': photoURL,
      'createdAt': createdAt,
      'role': role.apiValue,
    };
  }
}
