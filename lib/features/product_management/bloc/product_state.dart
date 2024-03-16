import 'package:equatable/equatable.dart';
import '../../../core/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class AddProductLoading extends ProductState {}

class AddProductSuccessState extends ProductState {
  final String message;
  const AddProductSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class AddProductFailureState extends ProductState {
  final String message;

  const AddProductFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductLoaded extends ProductState {
  final Product product;

  const ProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchProductLoading extends ProductState {}

class FetchProductSuccessState extends ProductState {
  final List<Product> products;
  const FetchProductSuccessState(this.products);
  @override
  List<Object?> get props => [products];
}

class FetchProductFailureState extends ProductState {
  final String message;

  const FetchProductFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchProductLoading extends ProductState {}

class SearchProductSuccessState extends ProductState {
  final List<Product> products;
  const SearchProductSuccessState(this.products);
  @override
  List<Object?> get props => [products];
}

class SearchProductFailureState extends ProductState {
  final String message;

  const SearchProductFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
