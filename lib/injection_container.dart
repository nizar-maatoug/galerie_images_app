import 'package:flutter/cupertino.dart';
import 'package:galerie_images_app/core/firebase/firebase_service.dart';
import 'package:galerie_images_app/core/network/network_info.dart';
import 'package:galerie_images_app/features/auth/data/datasources/user_data_source.dart';
import 'package:galerie_images_app/features/auth/data/repositories/user_repository_impl.dart';
import 'package:galerie_images_app/features/auth/domain/repositories/user_repository.dart';
import 'package:galerie_images_app/features/auth/domain/usecases/register_user.dart';
import 'package:galerie_images_app/features/auth/domain/usecases/sign_in_user.dart';
import 'package:galerie_images_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:galerie_images_app/navigation/app_router.dart';
import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  print("sl1");

  //sl.registerFactory(() => AuthBloc(
  //    signInUserUseCase: sl(),
  //  signOutUserUseCase: sl(),
  //));
  sl.registerLazySingleton(
      () => AuthBloc(signInUserUseCase: sl(), signOutUserUseCase: sl()));
  sl.registerFactory(() => UserManagerBloc(registerUserUseCase: sl()));

  print("sl2");

// Usecases

  print("sl3");
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUserUseCase(sl()));

  print("sl4");

// Repository

  print("sl5");
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(firebaseService: sl()));

//! Core

  sl.registerLazySingleton<NetwortkInfo>(() => NetwortkInfoImpl(sl()));

//! External

  

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //Firebase Service
  final firebaseService = await FirebaseService.init();
  sl.registerLazySingleton(() => firebaseService);

  //Router
  sl.registerLazySingleton(() => AppRouter());
}
