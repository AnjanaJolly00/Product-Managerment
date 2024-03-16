import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data/repository/product_repo.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<AddProduct>(onAddProduct);
    on<FetchProducts>(fetchProducts);
    on<SearchProducts>(searchProducts);
    on<FetchProductDetails>(getProductFromScan);
  }

  bool _isSearchDone = false;
  bool get isSearchDone => _isSearchDone;

  Future<void> onAddProduct(AddProduct event, Emitter emit) async {
    if (event.product.measurement.isEmpty ||
        event.product.price.toString().isEmpty ||
        event.product.name.isEmpty ||
        event.product.price == 0) {
      emit(const AddProductFailureState("Enter all the details to proceed"));
    } else {
      emit(AddProductLoading());
      var response = await productRepository.addProduct(event.product);
      if (response.isSuccessful) {
        emit(const AddProductSuccessState("Product Added Successfully"));
      } else {
        emit(AddProductFailureState(response.errorMsg ?? ""));
      }
    }
  }

  Future<void> fetchProducts(FetchProducts event, Emitter emit) async {
    emit(FetchProductLoading());
    var response = await productRepository.getProducts();
    if (response.isSuccessful) {
      _isSearchDone = false;
      emit(FetchProductSuccessState(response.rawResponse ?? []));
    } else {
      emit(FetchProductFailureState(response.errorMsg ?? ""));
    }
  }

  Future<void> searchProducts(SearchProducts event, Emitter emit) async {
    emit(FetchProductLoading());
    var response = await productRepository.searchProducts(event.query);
    if (response.isSuccessful) {
      _isSearchDone = true;
      emit(FetchProductSuccessState(response.rawResponse ?? []));
    } else {
      emit(FetchProductFailureState(response.errorMsg ?? ""));
    }
  }

  Future<void> getProductFromScan(
      FetchProductDetails event, Emitter emit) async {
    emit(FetchProductLoading());
    var res = await productRepository.getProductDetails(event.scan);
    if (res.isSuccessful) {
      _isSearchDone = true;
      emit(FetchProductSuccessState(res.rawResponse ?? []));
    } else {
      emit(FetchProductFailureState(res.errorMsg ?? ""));
    }
  }
}
