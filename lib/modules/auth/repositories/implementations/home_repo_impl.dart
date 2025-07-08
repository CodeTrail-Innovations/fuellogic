import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuellogic/modules/auth/repositories/interfaces/home_repo.dart';

 
class HomeRepositoryImpl implements HomeRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override

  Future<Map<String, dynamic>> fetchCurrentUserData() async {
    try {
      final User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        } else {
          throw Exception('User document does not exist in Firestore');
        }
      } else {
        throw Exception('No user is currently logged in');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
