// import 'dart:developer';
//
// import 'package:get/get.dart';
// import '../../data_manager/models/user_model.dart';
// import '../../data_manager/repositories/auth_repository/auth_repository.dart';
// import '../../data_manager/session/user_session_manager.dart';
// import '../../presentation/routes/app_routes.dart';
//
// class AuthService extends GetxService {
//   late final AuthRepository _authRepository;
//   late final UserSessionManager _sessionManager;
//   final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     _authRepository = AuthRepository();
//     _sessionManager = UserSessionManager();
//   }
//
//   Future<UserModel?> getCurrentUser() async {
//     final user = _sessionManager.currentUser;
//     if (user == null) return null;
//
//     // Get fresh user data from repository
//     final freshUser = await _authRepository.getUserById(user.uid);
//     if (freshUser != null) {
//       currentUser.value = freshUser;
//     }
//     return freshUser;
//   }
//
//   Future<void> loadSession() async {
//     await _sessionManager.loadSession();
//     if (_sessionManager.currentUser != null) {
//       final freshUserData = await getCurrentUser();
//       if (freshUserData != null) {
//         await _sessionManager.saveSession(freshUserData);
//         _navigateBasedOnRole(freshUserData.role);
//       } else {
//         await _sessionManager.clearSession();
//         Get.offAllNamed(AppRoutes.login);
//       }
//     } else {
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
//
//   void _navigateBasedOnRole(String role) {
//     switch (role.toLowerCase()) {
//       case 'admin':
//         Get.offAllNamed(AppRoutes.adminMainScreen);
//         break;
//       case 'user':
//         Get.offAllNamed(AppRoutes.userMainScreen);
//         break;
//       default:
//         Get.offAllNamed(AppRoutes.home);
//         break;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _sessionManager.signOut();
//     currentUser.value = null;
//     Get.offAllNamed(AppRoutes.home);
//   }
//
//   Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final user = await _authRepository.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (user != null) {
//         currentUser.value = user;
//         await _sessionManager.saveSession(user);
//       }
//       return user;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to sign in: $e');
//       return null;
//     }
//   }
//
//   Future<UserModel?> signUpUser({
//     required String email,
//     required String password,
//     required String name,
//     required String phoneNumber,
//     required String role,
//     Map<String, dynamic>? additionalData,
//   }) async {
//     try {
//       log('111111');
//       final user = await _authRepository.signUp(
//         email: email,
//         password: password,
//         name: name,
//         role: role,
//         additionalData: {
//           'phoneNumber': phoneNumber,
//           ...?additionalData,
//         },
//       );
//       log('2222 $user');
//
//       if (user != null) {
//         currentUser.value = user;
//         await _sessionManager.saveSession(user);
//       }
//       return user;
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to sign up: $e');
//       return null;
//     }
//   }
//
//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _authRepository.resetPassword(email);
//     } catch (e) {
//       throw e.toString();
//     }
//   }
//
//   bool get isLoggedIn => currentUser.value != null;
//   bool get isAdmin => currentUser.value?.role.toLowerCase() == 'admin';
//   bool get isUser => currentUser.value?.role.toLowerCase() == 'user';
//
//   String? get userId => currentUser.value?.uid;
//   String? get userEmail => currentUser.value?.email;
//   String? get userName => currentUser.value?.name;
//   String? get userRole => currentUser.value?.role;
//
// }
