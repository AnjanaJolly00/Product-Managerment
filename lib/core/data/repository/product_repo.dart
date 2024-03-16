import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machinetest/core/data/models/api_response.dart';
import '../models/product_model.dart';

class ProductRepository {
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('products');

  Future<ApiResponse<DocumentReference<Object?>>> addProduct(
      Product product) async {
    try {
      var res = await _productCollection.add(product.toMap());
      return ApiResponse(isSuccessful: true, rawResponse: res);
    } on FirebaseException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  Future<ApiResponse<List<Product>>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _productCollection.get();
      var list = snapshot.docs
          .map((doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      return ApiResponse(isSuccessful: true, rawResponse: list);
    } on FirebaseException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _productCollection.doc(product.name).update(product.toMap());
    } catch (e) {
      // Handle error

      rethrow; // Throw the error again for handling at a higher level
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productCollection.doc(productId).delete();
    } catch (e) {
      // Handle error

      rethrow; // Throw the error again for handling at a higher level
    }
  }

  Future<ApiResponse<List<Product>>> searchProducts(String query) async {
    try {
      QuerySnapshot snapshot =
          await _productCollection.where('name', isLessThan: query).get();

      var list = snapshot.docs
          .map((doc) =>
              Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      return ApiResponse(isSuccessful: true, rawResponse: list);
    } on FirebaseException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  Future<ApiResponse> getProductDetails(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _productCollection.doc(id).get();
      if (docSnapshot.exists) {
        var product = Product.fromFirestore(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
        return ApiResponse(isSuccessful: true, rawResponse: [product]);
      } else {
        return ApiResponse(
            isSuccessful: false,
            rawResponse: null,
            errorMsg: "Product with ID $id not found");
      }
    } on FirebaseException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }
}
