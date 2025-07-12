import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../modules/orders/models/order_model.dart';

class FcmService {
  final ServiceAccountCredentials _creds;
  final String _projectId;

  FcmService(this._creds, this._projectId);

  Future<String> _getAccessToken() async => (await clientViaServiceAccount(
      _creds,
      ['https://www.googleapis.com/auth/firebase.messaging']
  )).credentials.accessToken.data;

  Future<void> _sendMessage({
    required String token,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    final accessToken = await _getAccessToken();
    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send'
    );

    final payload = {
      'message': {
        'token': token,
        'notification': {'title': title, 'body': body},
        if (data != null) 'data': data,
      }
    };

    final resp = await http.post(
      url,
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'Authorization':'Bearer $accessToken',
      },
      body: jsonEncode(payload),
    );

    if (resp.statusCode != 200) {
      throw Exception('FCM send failed: ${resp.statusCode} ${resp.body}');
    }
  }

  Future<List<String>> _getTokens(List<String> uids) async {
    final tokens = <String>[];
    final col = FirebaseFirestore.instance.collection('device_tokens');
    for (var uid in uids.where((u) => u.isNotEmpty)) {
      final doc = await col.doc(uid).get();
      final token = doc.data()?['device_token'];
      if (token is String) tokens.add(token);
    }
    return tokens;
  }

  Future<void> notifyCustomer(OrderModel order, String title, String body) async {
    final uids = [order.companyId, order.driverId ?? ''];
    final tokens = await _getTokens(uids);
    for (final t in tokens) {
      await _sendMessage(
        token: t,
        title: 'Your Order Update',
        body: body,
        data: {'orderId': order.id},
      );
    }
  }

  Future<void> notifyAdmins(OrderModel order) async {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();

    final uids = snap.docs.map((d) => d.id).toList();
    final tokens = await _getTokens(uids);

    for (final t in tokens) {
      await _sendMessage(
        token: t,
        title: '🔔 New Order ',
        // title: '🔔 New Order ${order.id}',
        body: 'Details: ${order.description}',
        data: {'orderId': order.id},
      );
    }
  }
}
