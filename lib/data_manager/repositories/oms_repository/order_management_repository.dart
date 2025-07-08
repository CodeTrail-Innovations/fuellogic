 import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

import '../../models/customer_model.dart';
import '../../models/order_model.dart';

class OrderManagementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uuid = Uuid();
  final _ordersCollection = FirebaseFirestore.instance.collection('orders');



  Future<void> saveCustomer(Customer customer) async {
    await _firestore
        .collection('customers')
        .doc(customer.customerId)
        .set(customer.toJson());
  }

  Future<void> saveOrder(OrderModel order) async {
    await _firestore
        .collection('orders')
        .doc(order.orderId)
        .set(order.toJson());
  }

  Future<void> updateOrder(OrderModel order) async {
    await _firestore
        .collection('orders')
        .doc(order.orderId)
        .update(order.toJson());
  }

  Future<List<Customer>> searchCustomers(String query) async {
    final q = query.trim().toLowerCase();

    final snap = await _firestore
        .collection('customers')
        .where('nameKeywords', arrayContains: q)
        .limit(200)
        .get();

    return snap.docs.map((d) => Customer.fromJson(d.data())).toList();
  }

  Stream<List<Customer>> customersStream() =>
      _firestore.collection('customers')
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => Customer.fromJson(d.data())).toList());

  /// 1️⃣ All orders
  Stream<List<OrderModel>> ordersStream() =>
      _firestore.collection('orders')
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());

  /// 2️⃣ By customerId
  Stream<List<OrderModel>> ordersByCustomer(String customerId) =>
      _firestore.collection('orders')
          .where('customerId', isEqualTo: customerId)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());

  /// 3️⃣ By paymentStatus
  Stream<List<OrderModel>> ordersByPaymentStatus(String status) =>
      _firestore.collection('orders')
          .where('paymentStatus', isEqualTo: status)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());

  /// 4️⃣ By orderStatus
  Stream<List<OrderModel>> ordersByOrderStatus(String status) =>
      _firestore.collection('orders')
          .where('orderStatus', isEqualTo: status)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());

  /// 5️⃣ By orderType
  Stream<List<OrderModel>> ordersByOrderType(String type) =>
      _firestore.collection('orders')
          .where('orderType', isEqualTo: type)
          .orderBy('orderDate', descending: true)
          .snapshots()
          .map((snap) =>
          snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());

  /// 6️⃣ Search by customer name (uses embedded Customer.nameLower & nameKeywords)
  Future<List<OrderModel>> searchOrdersByCustomerName(String query) async {
    final q = query.trim().toLowerCase();
    // First find matching customers
    final custSnap = await _firestore
        .collection('customers')
        .where('nameKeywords', arrayContains: q)
        .get();
    final ids = custSnap.docs.map((d) => d['customerId'] as String).toList();
    if (ids.isEmpty) return [];

    // Then fetch orders for those IDs
    final orderSnap = await _firestore
        .collection('orders')
        .where('customerId', whereIn: ids)
        .orderBy('orderDate', descending: true)
        .get();
    return orderSnap.docs
        .map((d) => OrderModel.fromJson(d.data()))
        .toList();
  }



  Future<void> updateOrderStatus(OrderModel order) async {
    await _ordersCollection.doc(order.orderId).update(order.toJson());
  }

  Future<void> deleteOrder(String orderId) async {
    await _ordersCollection.doc(orderId).delete();
  }




  String generateId() => uuid.v1();
}