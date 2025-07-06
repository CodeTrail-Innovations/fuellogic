import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_line_model.dart';

/// MODEL: Order (may contain multiple products)
class UserOrder {
  final String id;
  final String userId;
  final List<OrderLine> lines;
  final double totalCost;
  final DateTime timestamp;
  final String orderStatus;
  final String? challanSerial;
  final String? deliveredBy;
  final String? receivedBy;
  final String? paymentStatus;

  UserOrder({
    required this.id,
    required this.userId,
    required this.lines,
    required this.totalCost,
    required this.timestamp,
    required this.orderStatus,
    this.challanSerial,
    this.deliveredBy,
    this.paymentStatus,
    this.receivedBy,
  });

  UserOrder copyWith({
    String? id,
    String? userId,
    List<OrderLine>? lines,
    double? totalCost,
    DateTime? timestamp,
    String? orderStatus,
    String? challanSerial,
    String? deliveredBy,
    String? receivedBy,
    String? paymentStatus
  }) {
    return UserOrder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lines: lines ?? this.lines,
      totalCost: totalCost ?? this.totalCost,
      timestamp: timestamp ?? this.timestamp,
      orderStatus: orderStatus ?? this.orderStatus,
      challanSerial: challanSerial ?? this.challanSerial,
      deliveredBy: deliveredBy ?? this.deliveredBy,
      receivedBy: receivedBy ?? this.receivedBy,
      paymentStatus: paymentStatus ?? this.paymentStatus,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'lines': lines.map((l) => l.toMap()).toList(),
      'totalCost': totalCost,
      'timestamp': timestamp.toIso8601String(),
      'orderStatus': orderStatus,
      'challanSerial': challanSerial,
      'deliveredBy': deliveredBy,
      'receivedBy': receivedBy,
      'paymentStatus': paymentStatus,

    };
  }


  factory UserOrder.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserOrder(
      id: doc.id,
      userId: data['userId'],
      orderStatus: data['orderStatus'] as String,
      challanSerial: data['challanSerial'] as String?,
      deliveredBy: data['deliveredBy'] as String?,
      paymentStatus: data['paymentStatus'] as String?,
      lines: (data['lines'] as List<dynamic>)
          .map((e) => OrderLine.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      totalCost: (data['totalCost'] as num).toDouble(),
      timestamp: DateTime.parse(data['timestamp'] as String),
    );
  }
}
