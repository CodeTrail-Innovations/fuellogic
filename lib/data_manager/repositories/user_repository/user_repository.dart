

import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../../helper/services/auth_service.dart';
import '../../models/user_models/item_model.dart';
import '../../models/user_models/order_line_model.dart';
import '../../models/user_models/order_model.dart';
import '../../models/user_models/product_model.dart';

class OrderManagementRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _products = FirebaseFirestore.instance.collection('products');
  final _orders = FirebaseFirestore.instance.collection('orders');
  final _items = FirebaseFirestore.instance.collection('items');
  final authService = Get.find<AuthService>();
  final uuid = Uuid();
  late final String _userId;

  OrderManagementRepository() { _init(); }

  Future<void> _init() async {
    await authService.loadSession();
    final user = await authService.getCurrentUser();
    _userId = user!.uid;
  }

  /// PRODUCTS
  Stream<List<Product>> getProducts() =>
      _products.snapshots().map((snap) =>
          snap.docs.map((d) => Product.fromDoc(d)).toList());
  Future<Product> getProductById(String id) async =>
      Product.fromDoc(await _products.doc(id).get());

  /// ORDERS
  Stream<List<UserOrder>> getOrders() => _orders
      .where('userId', isEqualTo: _userId)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => UserOrder.fromDoc(d)).toList());

  Future<void> addOrder(List<Map<String, dynamic>> cart) async {
    // cart: list of { productId, quantity }
    final lines = <OrderLine>[];
    double total = 0;
    for (var item in cart) {
      final prod = await getProductById(item['productId']);
      final qty = (item['quantity'] as num).toDouble();
      final lineCost = prod.price * qty * (1 + prod.taxPercentage / 100);
      total += lineCost;
      lines.add(OrderLine(
        productId: prod.id,
        quantity: qty,
        price: prod.price,
        taxPercentage: prod.taxPercentage,
        unit: prod.unit,
        lineTotal: lineCost,
      ));
    }
    final order = UserOrder(
        id: uuid.v4(),
        userId: _userId,
        lines: lines,
        totalCost: total,
        timestamp: DateTime.now(),
        orderStatus: 'Pending',
      paymentStatus: 'Unpaid',

    );
    await _orders.doc(order.id).set(order.toMap());
  }

  Future<void> updateOrder(UserOrder order) async =>
      _orders.doc(order.id).update(order.toMap());
  Future<void> deleteOrder(String id) async =>
      _orders.doc(id).delete();


  Future<double> getTotalSpent() async {
    final snap = await _orders.where('userId', isEqualTo: _userId).get();
    return snap.docs
        .map((d) => (d.data()['totalCost'] as num).toDouble())
        .fold<double>(0.0, (a, b) => a + b);
  }


  Future<DateTime?> getLastOrderDate() async {
    final snap = await _orders
        .where('userId', isEqualTo: _userId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return DateTime.parse(snap.docs.first.data()['timestamp'] as String);
  }


}
