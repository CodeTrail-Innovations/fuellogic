// File: data_manager/models/user_models/item_entry.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemEntry {
  final String id;
  final String itemId;
  final DateTime timestamp;
  final double tripLength;
  final double fuelAssigned;
  final String productId;    // which fuel
  final double cost;         // calculated cost

  ItemEntry({
    required this.id,
    required this.itemId,
    required this.timestamp,
    required this.tripLength,
    required this.fuelAssigned,
    required this.productId,
    required this.cost,
  });

  Map<String, dynamic> toMap() => {
    'itemId': itemId,
    'timestamp': timestamp.toIso8601String(),
    'tripLength': tripLength,
    'fuelAssigned': fuelAssigned,
    'productId': productId,
    'cost': cost,
  };

  factory ItemEntry.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ItemEntry(
      id: doc.id,
      itemId: d['itemId'],
      timestamp: DateTime.parse(d['timestamp']),
      tripLength: (d['tripLength'] as num).toDouble(),
      fuelAssigned: (d['fuelAssigned'] as num).toDouble(),
      productId: d['productId'],
      cost: (d['cost'] as num).toDouble(),
    );
  }
}
