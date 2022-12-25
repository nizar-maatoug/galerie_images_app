import 'package:firebase_auth/firebase_auth.dart';
import 'package:galerie_images_app/core/firebase/firebase_service.dart';
import 'package:galerie_images_app/features/auth/data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserCredential> registerUser(UserModel userModel);
  Future<UserCredential> signInUser(UserModel userModel);
  Future<void> signOutUser();
  Future<void>? updateUserName(String userName);
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseService firebaseService;

  UserDataSourceImpl({required this.firebaseService});
  @override
  Future<UserCredential> registerUser(UserModel userModel) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email!, password: userModel.password!);
  }

  @override
  Future<UserCredential> signInUser(UserModel userModel) {
    print('login131');
    print(userModel.email);
    print(userModel.password);
    //return firebaseService.getAuth().signInWithEmailAndPassword(
    //email: userModel.email!, password: userModel.password!);
    return firebaseService.getAuth().signInWithEmailAndPassword(
        email: "nizar10@gmail.com", password: "nizarnizar");
  }

  @override
  Future<void> signOutUser() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<void>? updateUserName(String userName) {
    return FirebaseAuth.instance.currentUser?.updateDisplayName(userName);
  }
}
