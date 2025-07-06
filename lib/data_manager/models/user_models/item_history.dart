// File: item_history_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemHistory {
  final String id;
  final String itemId;
  final DateTime timestamp;
  final double stock;
  final String note;

  ItemHistory({
    required this.id,
    required this.itemId,
    required this.timestamp,
    required this.stock,
    required this.note,
  });

  Map<String, dynamic> toMap() => {
    'itemId': itemId,
    'timestamp': timestamp.toIso8601String(),
    'stock': stock,
    'note': note,
  };


  // ItemHistory Model
  factory ItemHistory.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemHistory(
      id: doc.id,
      itemId: data['itemId'],
      timestamp: DateTime.parse(data['timestamp']),
      stock: (data['stock'] as num).toDouble(),
      note: data['note'],
    );
  }

// factory ItemHistory.fromDoc(
  //     DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return ItemHistory(
  //     id: doc.id,
  //     itemId: data['itemId'],
  //     timestamp: DateTime.parse(data['timestamp']),
  //     stock: (data['stock'] as num).toDouble(),
  //     note: data['note'],
  //   );
  // }
}