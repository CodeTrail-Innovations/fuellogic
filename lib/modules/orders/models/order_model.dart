import 'package:fuellogic/core/enums/enum.dart';

class OrderModel {
  final String id;
  final String companyId;
  final String location;
  final String quantity;
  final String date;
  final OrderStatus orderStatus;
  final String? driverId;
  final String? driverName;
  final String description;
  final double? orderTotal;
  final String? dcBook;

  static const OrderStatus defaultOrderStatus = OrderStatus.pending;

  OrderModel({
    this.id = '',
    this.companyId = '',
    this.location = '',
    this.quantity = '',
    this.description = '',
    this.date = '',
    this.orderStatus = defaultOrderStatus,
    this.driverId = '',
    this.driverName = '',
    this.orderTotal,
    this.dcBook,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      companyId: json['companyId']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      quantity: json['quantity']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      orderStatus: _parseOrderStatus(json['orderStatus']),
      driverId: json['driverId']?.toString() ?? '',
      driverName: json['driverName']?.toString() ?? '',
      orderTotal: json['orderTotal']?.toDouble(),
      dcBook: json['dcBook']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'location': location,
    'description': description,
    'quantity': quantity,
    'date': date,
    'orderStatus': orderStatus.name,
    'driverId': driverId,
    'driverName': driverName,
    'orderTotal': orderTotal,
    'dcBook': dcBook,
  };

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
    String? description,
    FuelUnit? fuelUnit,
    String? date,
    OrderStatus? orderStatus,
    String? driverId,
    String? driverName,
    double? orderTotal,
    String? dcBook,
  }) {
    return OrderModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      location: location ?? this.location,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      orderStatus: orderStatus ?? this.orderStatus,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      orderTotal: orderTotal ?? this.orderTotal,
      dcBook: dcBook ?? this.dcBook,
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, companyId: $companyId, location: $location, description: $description, quantity: $quantity, date: $date, orderStatus: ${orderStatus.name}, driverId: $driverId, driverName: $driverName, orderTotal: $orderTotal, dcBook: $dcBook)';
  }
}
