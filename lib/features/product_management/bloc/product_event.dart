import 'package:barcode_scan2/model/scan_result.dart';
import 'package:equatable/equatable.dart';
import '../../../core/data/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class FetchProducts extends ProductEvent {
  const FetchProducts();

  @override
  List<Object?> get props => [];
}

class FetchProductDetails extends ProductEvent {
  final String scan;

  const FetchProductDetails(this.scan);

  @override
  List<Object?> get props => [scan];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
