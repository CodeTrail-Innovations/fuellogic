import 'package:cloud_firestore/cloud_firestore.dart';

/// MODEL: Item (user's fuel-consuming assets)
class Item {
  final String id;
  final String userId;
  final String name;
  final String type; // vehicle, generator, etc.
  final double capacity;
  final double currentStock;

  Item({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.capacity,
    required this.currentStock,
  });

  Item copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    double? capacity,
    double? currentStock,
  }) {
    return Item(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      capacity: capacity ?? this.capacity,
      currentStock: currentStock ?? this.currentStock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'type': type,
      'capacity': capacity,
      'currentStock': currentStock,
    };
  }

  factory Item.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      userId: data['userId'],
      name: data['name'],
      type: data['type'],
      capacity: (data['capacity'] as num).toDouble(),
      currentStock: (data['currentStock'] as num).toDouble(),
    );
  }


}