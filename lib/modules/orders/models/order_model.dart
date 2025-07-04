import 'dart:convert';

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

  OrderModel({
    required this.id,
    required this.location,
    required this.companyId,
    required this.fuelType,
    required this.quantity,
    required this.fuelUnit,
    required this.date,
    required this.orderStatus,
    required this.driverId,
    required this.driverName,
  });

  OrderModel copyWith({
    String? id,
    String? location,
    String? companyId,
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
      location: location ?? this.location,
      companyId: companyId ?? this.companyId,
      fuelType: fuelType ?? this.fuelType,
      quantity: quantity ?? this.quantity,
      fuelUnit: fuelUnit ?? this.fuelUnit,
      date: date ?? this.date,
      orderStatus: orderStatus ?? this.orderStatus,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location,
      'fuelType': fuelType.name,
      'quantity': quantity,
      'companyId': companyId,
      'fuelUnit': fuelUnit.name,
      'date': date,
      'orderStatus': orderStatus.name,
      'driverId': driverId,
      'driverName': driverName,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    try {
      return OrderModel(
        id: map['id'] as String,
        companyId: map['companyId'] as String,
        location: map['location'] as String,
        fuelType: _parseFuelType(map['fuelType']),
        quantity: map['quantity'] as String,
        fuelUnit: _parseFuelUnit(map['fuelUnit']),
        date: map['date'] as String,
        orderStatus: _parseOrderStatus(map['orderStatus']),
        driverId: map['driverId'] as String,
        driverName: map['driverName'] as String,
      );
    } catch (e) {
      throw Exception('Error parsing OrderModel from map: $e. Map data: $map');
    }
  }

  // Helper methods for safer enum parsing
  static FuelType _parseFuelType(dynamic value) {
    if (value == null) return FuelType.gaseous;

    try {
      return FuelType.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toString().toLowerCase(),
        orElse: () => FuelType.gaseous,
      );
    } catch (e) {
      return FuelType.gaseous;
    }
  }

  static FuelUnit _parseFuelUnit(dynamic value) {
    if (value == null) return FuelUnit.liters;

    try {
      return FuelUnit.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toString().toLowerCase(),
        orElse: () => FuelUnit.liters,
      );
    } catch (e) {
      return FuelUnit.liters;
    }
  }

  static OrderStatus _parseOrderStatus(dynamic value) {
    if (value == null) return OrderStatus.pending;

    try {
      return OrderStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toString().toLowerCase(),
        orElse: () => OrderStatus.pending,
      );
    } catch (e) {
      return OrderStatus.pending;
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, location: $location, companyId: $companyId,  fuelType: $fuelType, quantity: $quantity, fuelUnit: $fuelUnit, date: $date, orderStatus: $orderStatus, driverId: $driverId, driverName: $driverName)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.location == location &&
        other.fuelType == fuelType &&
        other.quantity == quantity &&
        other.companyId == companyId &&
        other.fuelUnit == fuelUnit &&
        other.date == date &&
        other.orderStatus == orderStatus &&
        other.driverId == driverId &&
        other.driverName == driverName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        location.hashCode ^
        fuelType.hashCode ^
        companyId.hashCode ^
        quantity.hashCode ^
        fuelUnit.hashCode ^
        date.hashCode ^
        orderStatus.hashCode ^
        driverId.hashCode ^
        driverName.hashCode;
  }
}
