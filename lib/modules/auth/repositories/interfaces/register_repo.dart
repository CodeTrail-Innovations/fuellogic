abstract class RegisterRepository {
  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>?> getCurrentUserData();
}
 