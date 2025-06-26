abstract class LoginRepository {
  Future<void> userSignIn({required String email, required String password});
}
