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

enum OrderStatus { onTheWay, pending, approved, delivered }

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.onTheWay:
        return 'On the way';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.approved:
        return 'Approved';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  String get apiValue {
    return name;
  }

  static OrderStatus fromApi(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'approved':
        return OrderStatus.approved;
      case 'delivered':
        return OrderStatus.delivered;
      case 'ontheway':
      case 'on_the_way':
      case 'on-the-way':
        return OrderStatus.onTheWay;
      default:
        return OrderStatus.onTheWay;
    }
  }
}
