import 'package:fuellogic/core/enums/enum.dart';

class OrderModel {
  final String id;
  final String companyId;
  final String location;
  final String quantity;
  final String date;
  final DateTime createdAt;
  final OrderStatus orderStatus;
  final PaymentStatus? paymentStatus;
  final String? driverId;
  final String? driverName;
  final String description;
  final double? orderTotal;
  final String? dcBook;

  static const OrderStatus defaultOrderStatus = OrderStatus.pending;
  static const PaymentStatus defaultPaymentStatus = PaymentStatus.unpaid;

  OrderModel({
    this.id = '',
    this.companyId = '',
    this.location = '',
    this.quantity = '',
    this.description = '',
    this.date = '',
    this.orderStatus = defaultOrderStatus,
    this.paymentStatus = defaultPaymentStatus,
    this.driverId = '',
    this.driverName = '',
    this.orderTotal,
    this.dcBook,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.utc(1989, 11, 9);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    DateTime parseCreatedAt() {
      if (json['createdAt'] != null) {
        try {
          return DateTime.parse(json['createdAt'].toString());
        } catch (e) {
          final ms = int.tryParse(json['createdAt'].toString());
          if (ms != null) return DateTime.fromMillisecondsSinceEpoch(ms);
        }
      }
      return DateTime.utc(2025, 07, 07);
    }

    return OrderModel(
      id: json['id']?.toString() ?? '',
      companyId: json['companyId']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      quantity: json['quantity']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      orderStatus: _parseOrderStatus(json['orderStatus']),
      paymentStatus: _parsePaymentStatus(json['paymentStatus']),
      driverId: json['driverId']?.toString() ?? '',
      driverName: json['driverName']?.toString() ?? '',
      orderTotal: (json['orderTotal'] is num)
          ? (json['orderTotal'] as num).toDouble()
          : double.tryParse(json['orderTotal']?.toString() ?? ''),
      dcBook: json['dcBook']?.toString(),
      createdAt: parseCreatedAt(),
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
    'paymentStatus':paymentStatus?.name,
    'driverId': driverId,
    'driverName': driverName,
    'orderTotal': orderTotal,
    'dcBook': dcBook,
    'createdAt': createdAt.toIso8601String(),
  };

  OrderModel copyWith({
    String? id,
    String? companyId,
    String? location,
    String? quantity,
    String? description,
    String? date,
    DateTime? createdAt,
    OrderStatus? orderStatus,
    PaymentStatus? paymentStatus,
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
      paymentStatus: paymentStatus ?? this.paymentStatus,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      orderTotal: orderTotal ?? this.orderTotal,
      dcBook: dcBook ?? this.dcBook,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static OrderStatus _parseOrderStatus(dynamic value) {
    try {
      return OrderStatus.fromValue(value?.toString() ?? '');
    } catch (e) {
      return defaultOrderStatus;
    }
  }


  static PaymentStatus _parsePaymentStatus(dynamic value) {
    try {
      return PaymentStatus.fromValue(value?.toString() ?? '');
    } catch (e) {
      return defaultPaymentStatus;
    }
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, companyId: $companyId, location: $location, description: $description, quantity: $quantity, date: $date, createdAt: $createdAt, orderStatus: ${orderStatus.name}, driverId: $driverId, driverName: $driverName, orderTotal: $orderTotal, dcBook: $dcBook)';
  }
}
