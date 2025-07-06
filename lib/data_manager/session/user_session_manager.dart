import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();
  factory UserSessionManager() => _instance;

  UserSessionManager._internal() {
    _prefs = Get.find<SharedPreferences>();
  }

  final _auth = FirebaseAuth.instance;
  late final SharedPreferences _prefs;

  static const String _roleKey = 'user_role';
  static const String _uidKey = 'user_uid';

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  Future<void> saveSession(UserModel user) async {
    _currentUser = user;
    print('saving user session: $user');
    print('saving user session: ${user.name}');
    await _prefs.setString(_roleKey, user.role.toString());
    await _prefs.setString(_uidKey, user.uid);
  }

  Future<void> clearSession() async {
    _currentUser = null;
    await _prefs.remove(_roleKey);
    await _prefs.remove(_uidKey);
  }

  Future<void> loadSession() async {
    print('loading user session');
    final role = _prefs.getString(_roleKey);
    final uid = _prefs.getString(_uidKey);

    print('loading user session: $role');
    print('loading user session: $uid');

    if (role != null && uid != null) {
      // We'll load the user data through the repository later
      _currentUser = UserModel(
          uid: uid,
          role: role,
          name: '',
          email: '',
          phoneNumber: '',
          createdAt: DateTime.now(),
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await clearSession();
  }
}
