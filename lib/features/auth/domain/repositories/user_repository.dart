

import 'package:dartz/dartz.dart';
import 'package:galerie_images_app/core/failures/failures.dart';
import 'package:galerie_images_app/features/auth/domain/entities/user_entity.dart';




abstract class UserRepository{

  Future<Either<Failure,Unit>> registerUser(UserEntity user);
  Future<Either<Failure,Unit>> updateUser(UserEntity user);

  Future<Either<Failure,Unit>> signIn(UserEntity user);
  Future<Either<Failure,Unit>> signOut();
}

