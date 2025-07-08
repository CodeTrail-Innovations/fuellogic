import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer_model.dart';

class OrderItem {
  String item;
  int quantity;
  double? rate;
  String? unit;
  double? itemTotal;

  OrderItem({
    required this.item,
    required this.quantity,
    this.rate,
    this.unit,
    this.itemTotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    item: json['item'] as String,
    unit: json['unit'] as String?,
    quantity: json['quantity'] as int,
    rate: (json['rate'] as num?)?.toDouble(),
    itemTotal: (json['itemTotal'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'item': item,
    'unit': unit,
    'quantity': quantity,
    if (rate != null) 'rate': rate,
    if (itemTotal != null) 'itemTotal': itemTotal,
  };
}

class OrderModel {
  final String orderId;
  final String customerId;
  final Customer customer;
  final String orderType;
  final DateTime orderDate;
  final List<OrderItem> items;
  final double total;
  final String? challanSerial;
  final String? region;
  final String? deliveredBy;
  final String? receivedBy;
  final String orderStatus;
  final String paymentStatus;

  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.customer,
    required this.orderType,
    required this.orderDate,
    required this.items,
    required this.total,
    this.challanSerial,
    this.region,
    this.deliveredBy,
    this.receivedBy,
    required this.orderStatus,
    required this.paymentStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json['orderId'] as String,
    customerId: json['customerId'] as String,
    customer: Customer.fromJson(json['customer']),
    orderType: json['orderType'] as String,
    orderDate: (json['orderDate'] as Timestamp).toDate(),
    items:
        (json['items'] as List)
            .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
    total: (json['total'] as num).toDouble(),
    challanSerial: json['challanSerial'] as String?,
    region: json['region'] as String?,
    deliveredBy: json['deliveredBy'] as String?,
    receivedBy: json['receivedBy'] as String?,
    orderStatus: json['orderStatus'] as String,
    paymentStatus: json['paymentStatus'] as String,
  );

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'customerId': customerId,
    'customer': customer.toJson(),
    'orderType': orderType,
    'orderDate': orderDate,
    'items': items.map((e) => e.toJson()).toList(),
    'total': total,
    if (challanSerial != null) 'challanSerial': challanSerial,
    if (region != null) 'region': region,
    if (deliveredBy != null) 'deliveredBy': deliveredBy,
    if (receivedBy != null) 'receivedBy': receivedBy,
    'orderStatus': orderStatus,
    'paymentStatus': paymentStatus,
  };

  OrderModel copyWith({
    String? orderId,
    String? customerId,
    Customer? customer,
    String? orderType,
    DateTime? orderDate,
    List<OrderItem>? items,
    double? total,
    String? challanSerial,
    String? region,
    String? deliveredBy,
    String? receivedBy,
    String? orderStatus,
    String? paymentStatus,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      customerId: customerId ?? this.customerId,
      customer: customer ?? this.customer,
      orderType: orderType ?? this.orderType,
      orderDate: orderDate ?? this.orderDate,
      items: items ?? this.items,
      total: total ?? this.total,
      challanSerial: challanSerial ?? this.challanSerial,
      region: region ?? this.region,
      deliveredBy: deliveredBy ?? this.deliveredBy,
      receivedBy: receivedBy ?? this.receivedBy,
      orderStatus: orderStatus ?? this.orderStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
