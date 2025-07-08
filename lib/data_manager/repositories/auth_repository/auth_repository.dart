import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../../session/user_session_manager.dart';

class AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserSessionManager _sessionManager = UserSessionManager();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String _getCollectionForRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return 'admins';
      case 'user':
        return 'users';
      default:
        return 'users';
    }
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      // Try each collection since we don't know the user's role
      final collections = ['users', 'admins'];

      for (final collection in collections) {
        final doc = await _firestore.collection(collection).doc(uid).get();
        if (doc.exists) {
          final data = doc.data()!;
          return UserModel(
            uid: uid,
            name: data['name'] ?? '',
            email: data['email'] ?? '',
            phoneNumber: data['phoneNumber'] ?? '',
            role: data['role'] ?? 'user',
            createdAt: (data['createdAt'] as Timestamp).toDate(),

          );
        }
      }
      return null;
    } catch (e) {
      log('Error getting user by ID: $e');
      return null;
    }
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final now = DateTime.now();
        final userData = {
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'role': role,
          'createdAt': now,
          ...?additionalData,
        };

        final collection = _getCollectionForRole(role);
        await _firestore
            .collection(collection)
            .doc(userCredential.user!.uid)
            .set(userData);

        final user = UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          phoneNumber: additionalData?['phoneNumber'] ?? '',
          role: role,
          createdAt: now,

          // imageUrl: additionalData?['imageUrl'],
        );

        await _sessionManager.saveSession(user);
        return user;
      }
      return null;
    } catch (e) {
      log('Error signing up: $e');
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final user = await getUserById(userCredential.user!.uid);
        if (user != null) {
          await _sessionManager.saveSession(user);
          return user;
        }
      }
      return null;
    } catch (e) {
      log('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _sessionManager.clearSession();
    } catch (e) {
      log('Error signing out: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  Future<UserModel?> getUserData({required String uid, required String role}) async {
    try {
      final collection = _getCollectionForRole(role);
      final doc = await _firestore.collection(collection).doc(uid).get();

      if (doc.exists) {
        final userData = UserModel(
          uid: uid,
          name: doc.data()!['name'] ?? '',
          email: doc.data()!['email'] ?? '',
          phoneNumber: doc.data()!['phoneNumber'] ?? '',
          role: doc.data()!['role'] ?? 'user',
          createdAt: (doc.data()!['createdAt'] as Timestamp).toDate(),

        );
        await _sessionManager.saveSession(userData);
        return userData;
      }
      return null;
    } catch (e) {
      log('Error getting user data: $e');
      return null;
    }
  }

  Future<bool> verifyAdminCode(String code) async {
    try {
      final adminCodes = await _firestore.collection('admin_codes').get();
      return adminCodes.docs.any((doc) => doc.data()['code'] == code);
    } catch (e) {
      log('Error verifying admin code: $e');
      return false;
    }
  }


}
