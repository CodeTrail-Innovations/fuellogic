import 'package:fuellogic/core/enums/enum.dart';

class OrderModel {
  final String id;
  final String companyId;
  final String location;
  final FuelType fuelType;
  final String quantity;
  final FuelUnit fuelUnit;
  final String date;
  final OrderStatus orderStatus;
  final String driverId;
  final String driverName;

  static const FuelType defaultFuelType = FuelType.gaseous;
  static const FuelUnit defaultFuelUnit = FuelUnit.liters;
  static const OrderStatus defaultOrderStatus = OrderStatus.pending;

  OrderModel({
    this.id = '',
    this.companyId = '',
    this.location = '',
    this.fuelType = defaultFuelType,
    this.quantity = '',
    this.fuelUnit = defaultFuelUnit,
    this.date = '',
    this.orderStatus = defaultOrderStatus,
    this.driverId = '',
    this.driverName = '',
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      companyId: json['companyId']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      fuelType: _parseFuelType(json['fuelType']),
      quantity: json['quantity']?.toString() ?? '',
      fuelUnit: _parseFuelUnit(json['fuelUnit']),
      date: json['date']?.toString() ?? '',
      orderStatus: _parseOrderStatus(json['orderStatus']),
      driverId: json['driverId']?.toString() ?? '',
      driverName: json['driverName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'location': location,
    'fuelType': fuelType.name,
    'quantity': quantity,
    'fuelUnit': fuelUnit.name,
    'date': date,
    'orderStatus': orderStatus.name,
    'driverId': driverId,
    'driverName': driverName,
  };

  static FuelType _parseFuelType(dynamic value) {
    try {
      return FuelType.fromValue(value?.toString() ?? '');
    } catch (e) {
      return defaultFuelType;
    }
  }

  static FuelUnit _parseFuelUnit(dynamic value) {
    try {
      return FuelUnit.fromValue(value?.toString() ?? '');
    } catch (e) {
      return defaultFuelUnit;
    }
  }

  static OrderStatus _parseOrderStatus(dynamic value) {
    try {
      return OrderStatus.fromValue(value?.toString() ?? '');
    } catch (e) {
      return defaultOrderStatus;
    }
  }

  OrderModel copyWith({
    String? id,
    String? companyId,
    String? location,
    FuelType? fuelType,
    String? quantity,
    FuelUnit? fuelUnit,
    String? date,
    OrderStatus? orderStatus,
    String? driverId,
    String? driverName,
  }) {
    return OrderModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      location: location ?? this.location,
      fuelType: fuelType ?? this.fuelType,
      quantity: quantity ?? this.quantity,
      fuelUnit: fuelUnit ?? this.fuelUnit,
      date: date ?? this.date,
      orderStatus: orderStatus ?? this.orderStatus,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, companyId: $companyId, location: $location, fuelType: ${fuelType.name}, quantity: $quantity, fuelUnit: ${fuelUnit.name}, date: $date, orderStatus: ${orderStatus.name}, driverId: $driverId, driverName: $driverName)';
  }
}
