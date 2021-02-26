import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseServices{
  FirebaseAuth _firebaseauth=FirebaseAuth.instance;

  String getuserid(){
     return  _firebaseauth.currentUser.uid;
  }

   final CollectionReference productRef =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference userref = FirebaseFirestore.instance
      .collection("Users");
}