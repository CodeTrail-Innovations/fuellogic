

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuellogic/modules/orders/models/order_model.dart';

class CompanyOrdersRepository {
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

  Stream<List<OrderModel>> getCompanyOrders(String uid) {
    return _orders
        .where("companyId", isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((query) => query.docs.map((doc) {
      final data = doc.data();
      return OrderModel.fromJson(data);
    }).toList());
  }

  Stream<List<OrderModel>> getDriverOrders(String uid) {
    return _orders
        .where("driverId", isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((query) => query.docs.map((doc) {
      final data = doc.data();
      return OrderModel.fromJson(data);
    }).toList());
  }



}