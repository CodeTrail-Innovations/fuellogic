import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:fuellogic/data_manager/models/order_model.dart';
import 'package:fuellogic/data_manager/models/user_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

import '../../../helper/services/auth_service.dart';
import '../../orders/models/order_model.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _companies = FirebaseFirestore.instance.collection('companies');
  final _drivers = FirebaseFirestore.instance.collection('drivers');
  final _products = FirebaseFirestore.instance.collection('products');
  final _orders = FirebaseFirestore.instance.collection('orders');
  final _items = FirebaseFirestore.instance.collection('items');
  final authService = Get.find<AuthService>();
  final uuid = Uuid();
  late final String _userId;

  CompanyRepository() { _init(); }

  Future<void> _init() async {
    await authService.loadSession();
    final user = await authService.getCurrentUser();
    _userId = user!.uid;
  }


  ///COMPANY PROFILE
  Stream<UserModel> getCompanyProfile() {
    return _companies.doc(_userId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      } else {
        throw Exception('Company document not found for UID: $_userId');
      }
    });
  }


  /// ORDERS
  Stream<List<OrderModel>> getOrders() => _orders
      .where('uid', isEqualTo: _userId)
      .where('companyId', isEqualTo: _userId)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => OrderModel.fromJson(d.data())).toList());


  Future<void> saveOrder(OrderModel order) async {
    await _firestore
        .collection('orders')
        .doc(order.id)
        .set(order.toJson());
  }



}