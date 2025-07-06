import 'package:cloud_firestore/cloud_firestore.dart';

/// MODEL: Product (orderable items)
class Product {
  final String id;
  final String name;
  final String code;
  final double price;
  final double taxPercentage;
  final String unit;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.taxPercentage,
    required this.unit,
  });

  Product copyWith({
    String? id,
    String? name,
    String? code,
    double? price,
    double? taxPercentage,
    String? unit,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'price': price,
      'tax_percentage': taxPercentage,
      'unit': unit,
    };
  }
  // factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   return Product(
  //     id: doc.id,
  //     name: data['name'] as String,
  //     code: data['code'] as String,
  //     price: (data['price'] as num).toDouble(),
  //     taxPercentage: (data['tax_percentage'] as num).toDouble(),
  //     unit: data['unit'] as String,
  //   );
  // }



  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] as String,
      code: data['code'] as String,
      price: (data['price'] as num).toDouble(),
      taxPercentage: (data['tax_percentage'] as num).toDouble(),
      unit: data['unit'] as String,
    );
  }
}