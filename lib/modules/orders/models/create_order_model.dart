import 'dart:convert';

import 'package:fuellogic/core/enums/enum.dart';

class OrderModel {
  final String id;
  final String location;
  final FuelType fuelType;
  final String quantity;
  final FuelUnit fuelUnit;
  final String date;
  OrderModel({
    required this.id,
    required this.location,
    required this.fuelType,
    required this.quantity,
    required this.fuelUnit,
    required this.date,
  });

  OrderModel copyWith({
    String? id,
    String? location,
    FuelType? fuelType,
    String? quantity,
    FuelUnit? fuelUnit,
    String? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      location: location ?? this.location,
      fuelType: fuelType ?? this.fuelType,
      quantity: quantity ?? this.quantity,
      fuelUnit: fuelUnit ?? this.fuelUnit,
      date: date ?? this.date,
    );
  }

Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location,
      'fuelType': fuelType.name,
      'quantity': quantity,
      'fuelUnit': fuelUnit.name, 
      'date': date,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      location: map['location'] as String,
      fuelType: FuelType.values.firstWhere((e) => e.name == map['fuelType']),
      quantity: map['quantity'] as String,
      fuelUnit: FuelUnit.values.firstWhere(
        (e) => e.name == map['fuelUnit'],
      ),  
      date: map['date'] as String,
    );
  }


  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderMode(id: $id, location: $location, fuelType: $fuelType, quantity: $quantity, fuelUnit: $fuelUnit, date: $date)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.location == location &&
        other.fuelType == fuelType &&
        other.quantity == quantity &&
        other.fuelUnit == fuelUnit &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        location.hashCode ^
        fuelType.hashCode ^
        quantity.hashCode ^
        fuelUnit.hashCode ^
        date.hashCode;
  }
}
