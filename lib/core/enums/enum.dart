enum UserRole {
  driver('driver'),
  company('company'),
  admin('admin');

  final String value;
  const UserRole(this.value);

  String get label {
    switch (this) {
      case UserRole.driver:
        return 'Driver';
      case UserRole.company:
        return 'Company';
      case UserRole.admin:
          return 'Admin';
    }
  }

  String get apiValue => value;

  static UserRole fromValue(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value.toLowerCase(),
     );
  }
}

enum FuelType {
  solid('solid'),
  liquid('liquid'),
  gaseous('gaseous');

  final String value;
  const FuelType(this.value);

  String get label {
    switch (this) {
      case FuelType.solid:
        return 'Solid';
      case FuelType.liquid:
        return 'Liquid';
      case FuelType.gaseous:
        return 'Gaseous';
    }
  }

  String get apiValue => value;

  static FuelType fromValue(String value) {
    return FuelType.values.firstWhere(
      (fuel) => fuel.value == value.toLowerCase(),
     );
  }
}

enum FuelUnit {
  liters('liters'),
  gallons('gallons');

  final String value;
  const FuelUnit(this.value);

  String get label {
    switch (this) {
      case FuelUnit.liters:
        return 'Liters';
      case FuelUnit.gallons:
        return 'Gallons';
    }
  }

  String get apiValue => value;

  static FuelUnit fromValue(String value) {
    return FuelUnit.values.firstWhere(
      (unit) => unit.value == value.toLowerCase(),
     );
  }
}

enum OrderStatus {
  onTheWay('ontheway'),
  pending('pending'),
  approved('approved'),
  delivered('delivered');

  final String value;
  const OrderStatus(this.value);

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

  String get apiValue => value;

  static OrderStatus fromValue(String value) {
    final formatted = value.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
    return OrderStatus.values.firstWhere(
      (status) => status.value == formatted,
     );
  }
}
