/// MODEL: OrderLine (single product line in an order)
class OrderLine {
  final String productId;
  final double quantity;
  final double price;
  final double taxPercentage;
  final String unit;
  final double lineTotal;

  OrderLine({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.taxPercentage,
    required this.unit,
    required this.lineTotal,
  });

  OrderLine copyWith({
    String? productId,
    double? quantity,
    double? price,
    double? taxPercentage,
    String? unit,
    double? lineTotal,
  }) {
    return OrderLine(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      unit: unit ?? this.unit,
      lineTotal: lineTotal ?? this.lineTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'tax_percentage': taxPercentage,
      'unit': unit,
      'lineTotal': lineTotal,
    };
  }

  factory OrderLine.fromMap(Map<String, dynamic> map) {
    return OrderLine(
      productId: map['productId'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      price: (map['price'] as num).toDouble(),
      taxPercentage: (map['tax_percentage'] as num).toDouble(),
      unit: map['unit'] as String,
      lineTotal: (map['lineTotal'] as num).toDouble(),
    );
  }
}
