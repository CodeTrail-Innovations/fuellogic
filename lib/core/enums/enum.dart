enum UserRole {
  driver('driver'),
  company('company');

  final String value;
  const UserRole(this.value);

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

  static UserRole fromValue(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value.toLowerCase(),
      // orElse: () => UserRole.driver,
    );
  }
}

enum FuelType { solid, liquid, gaseous }

extension FuelTypeExtension on FuelType {
  String get fuellabel {
    switch (this) {
      case FuelType.solid:
        return 'Solid';
      case FuelType.liquid:
        return 'Liquid';
      case FuelType.gaseous:
        return 'Gaseous';
    }
  }

  String get apiValue {
    return fuellabel;
  }

  static FuelType fromApi(String value) {
    switch (value.toLowerCase()) {
      case 'solid':
        return FuelType.solid;
      case 'liquid':
        return FuelType.liquid;
      case 'gaseous':
        return FuelType.gaseous;
      default:
        return FuelType.gaseous;
    }
  }
}

enum FuelUnit { liters, gallons }

extension FuelUnitExtension on FuelUnit {
  String get fuelUnit {
    switch (this) {
      case FuelUnit.liters:
        return 'Liters';
      case FuelUnit.gallons:
        return 'Gallons';
    }
  }

  String get apiValue {
    return fuelUnit;
  }

  static FuelUnit fromApi(String value) {
    switch (value.toLowerCase()) {
      case 'liters':
        return FuelUnit.liters;
      case 'gallons':
        return FuelUnit.gallons;
      default:
        return FuelUnit.gallons;
    }
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
