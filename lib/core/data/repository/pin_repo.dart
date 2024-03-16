import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PinRepository {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> storePinInFirestore(String pin) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      await usersCollection.doc(uid).set({
        'pin': pin,
      });
    }
  }

  Future<String?> getPinFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return (documentSnapshot.data() as Map<String, dynamic>)["pin"];
    }
    return null; // Return null if user is not logged in
  }
}
