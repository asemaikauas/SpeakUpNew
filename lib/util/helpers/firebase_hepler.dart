import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SFireHelper {
  static final fireAuth = FirebaseAuth.instance;
  static final fireStorage = FirebaseStorage.instance;
  static final fireStore = FirebaseFirestore.instance;
// static final fireAuth = FirebaseAuth.instance;
}
