import 'package:equatable/equatable.dart';

class Product extends Equatable {
  // Unique identifier for the product
  final String name;
  final String measurement;
  final double price;
  final id;

  // Additional fields can be added as needed

  const Product(
      {required this.name,
      required this.measurement,
      required this.price,
      this.id});

  @override
  List<Object?> get props => [name, measurement, price];

  // Factory method to create Product object from Firestore snapshot
  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
        name: data['name'] ?? '',
        measurement: data['measurement'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        id: id);
  }

  // Method to convert Product object to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'measurement': measurement,
      'price': price,
    };
  }
}
