import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static late FirebaseDatabase database;

  void initDatabase() {
    database = FirebaseDatabase.instance;
  }
}
