

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';

class AdminOrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _orders = FirebaseFirestore.instance.collection('orders');


  /// ORDERS
  Stream<List<OrderModel>> getOrders() {
    return _orders
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((query) => query.docs.map((doc) {
      final data = doc.data();
      return OrderModel.fromJson(data);
    }).toList());
  }
  // Stream<List<OrderModel>> getOrders() => _orders
  //     .orderBy('createdAt', descending: true)
  //     .snapshots()
  //     .map((snap) => snap.docs.map((d) => OrderModel.fromJson(d as Map<String, dynamic>)).toList());


}