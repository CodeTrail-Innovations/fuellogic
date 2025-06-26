enum UserRole { driver, company }

extension UserRoleExtension on UserRole {
  String get label {
    switch (this) {
      case UserRole.driver:
        return 'Driver';
      case UserRole.company:
        return 'Company';
    }
  }

  String get iconPath {
    switch (this) {
      case UserRole.driver:
        return 'assets/icons/driver.svg';
      case UserRole.company:
        return 'assets/icons/company.svg';
    }
  }

  String get apiValue {
    return name;
  }

  static UserRole fromApi(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value.toLowerCase(),
      orElse: () => UserRole.driver,
    );
  }
}
