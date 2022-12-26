import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:galerie_images_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:galerie_images_app/features/auth/presentation/widgets/login_form.dart';
import 'package:go_router/go_router.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:galerie_images_app/core/utils/snack_bar_message.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          GoRouter.of(context).goNamed('galerie');
        } else if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: LoginForm(),
      ),
    );
  }
}
