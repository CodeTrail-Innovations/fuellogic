import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuellogic/core/enums/user_role.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final Timestamp createdAt;
  final UserRole role;

  static final Timestamp defaultCreatedAt =
      Timestamp.fromMillisecondsSinceEpoch(1704067200000);

  UserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.photoURL = '',
    this.role = UserRole.driver,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? defaultCreatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
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
      'photoURL': photoURL,
      'createdAt': createdAt,
      'role': role.apiValue,
    };
  }
}
