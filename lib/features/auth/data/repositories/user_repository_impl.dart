import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:galerie_images_app/core/failures/auth_failures.dart';
import 'package:galerie_images_app/core/failures/failures.dart';
import 'package:galerie_images_app/core/network/network_info.dart';
import 'package:galerie_images_app/features/auth/data/datasources/user_data_source.dart';
import 'package:galerie_images_app/features/auth/data/models/user_model.dart';
import 'package:galerie_images_app/features/auth/domain/entities/user_entity.dart';
import 'package:galerie_images_app/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final NetwortkInfo networkInfo;

  UserRepositoryImpl({required this.userDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> registerUser(UserEntity user) async {
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);

    if (await networkInfo.isConnected) {
      try {
        final credential = await userDataSource.registerUser(userModel);
        return Right(unit);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return Left(RegisterUserWeakPwdFailure());
        } else if (e.code == 'email-already-in-use') {
          return Left(RegisterUserUsedEmailFailure());
        } else {
          return Left(RegisterUserFailure());
        }
      } catch (e) {
        return Left(RegisterUserFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn(UserEntity user) async {
    print('login1');
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);
    print('login12');
    //if (await networkInfo.isConnected) {
    //if (FirebaseAuth.instance.currentUser == null) {
    print("user null");
    try {
      print('login13');
      final credential = await userDataSource.signInUser(userModel);
      print('login14');
      print("user logged in: ");
      print(credential.user);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      print('login1: exception1');
      if (e.code == 'user-not-found') {
        print('login1: exception2');
        return Left(SignInUserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        print('login1: exception3');
        return Left(SignInWrongPwdFailure());
      } else {
        print('login1: exception4');
        return Left(SignInFailure());
      }
    } catch (e) {
      print('login1 exception22');
      return Left(SignInFailure());
    }
    //} else {
    //return Left(SignInFailure());
    //}
    //} else {
    // print('login1 offline');
    //return Left(OfflineFailure());
    //}
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      await FirebaseAuth.instance.signOut();
      return Right(unit);
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity user) async {
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);
    if (await networkInfo.isConnected) {
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(userModel.name);
      await FirebaseAuth.instance.currentUser?.updateEmail(userModel.email);
      await FirebaseAuth.instance.currentUser
          ?.updatePhotoURL(userModel.profilURL);
      return Right(unit);
    } else {
      return Left(OfflineFailure());
    }
  }
}
