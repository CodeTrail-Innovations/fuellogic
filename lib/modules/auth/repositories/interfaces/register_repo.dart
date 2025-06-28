import 'package:fuellogic/core/enums/enum.dart';

abstract class RegisterRepository {
  Future<void> userSignUp({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    required String comapanyId,
  });

  Future<Map<String, dynamic>?> getCurrentUserData();
}
