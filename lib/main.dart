import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galerie_images_app/core/app_theme.dart';
import 'package:galerie_images_app/features/auth/domain/entities/user_entity.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:galerie_images_app/navigation/app_router.dart';

import 'firebase_options.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider(
            create: (_) => di.sl<UserManagerBloc>()
              ..add(RegisterEvent(
                  user: UserEntity(
                      name: "nizar",
                      email: "nizar2@gmail.com",
                      password: "nizarnizar")))),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Galerie Images',
            theme: appTheme,
            routerConfig: di
                .sl<AppRouter>()
                .router, /*AppRouter(BlocProvider.of<AuthBloc>(context)).router*/
          );
        },
      ),
    );
  }
}
