
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //Ajouter les autres service (store,...)

  static Future<FirebaseService> init() async {
    await Firebase.initializeApp();
    return FirebaseService();
  }
  FirebaseAuth getAuth(){
    return _firebaseAuth;
  }
}
