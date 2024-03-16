import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machinetest/core/data/models/api_response.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ApiResponse(
          isSuccessful: true, rawResponse: userCredential, errorMsg: null);
    } on FirebaseAuthException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  Future<ApiResponse<UserCredential>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ApiResponse(
          isSuccessful: true, rawResponse: userCredential, errorMsg: null);
    } on FirebaseAuthException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  Future<ApiResponse<UserCredential>> signOut() async {
    try {
      await _auth.signOut();
      return ApiResponse(isSuccessful: true, rawResponse: null, errorMsg: null);
    } on FirebaseAuthException catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.message);
    } catch (e) {
      return ApiResponse(
          isSuccessful: false, rawResponse: null, errorMsg: e.toString());
    }
  }

  
}
