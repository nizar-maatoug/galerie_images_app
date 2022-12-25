import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galerie_images_app/features/auth/domain/entities/user_entity.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  //final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        /*if (state is AuthenticatedState) {
          GoRouter.of(context).goNamed('galerie');
        }*/
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Form(
          //key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'le email est obligatoire'; //dans le dossier Strings
                    }
                    if (!isEmail(value)) {
                      return "email incorrect";
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Entrer votre email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'le mot de passe est obligatoire'; //!! dans Strings
                    }
                    if (!isLength(value, 8)) {
                      return "mot de passe faible"; //dans Strings
                    }
                    return null;
                  },
                  controller: _pwdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Entrer votre mot de passe',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: validateAndLoginUser,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndLoginUser() {
    //if (_formKey.currentState!.validate()) {
    final user = UserEntity(
        name: "",
        email: _emailController.text.toString().trim(),
        password: _pwdController.text.toString().trim());

    final user1 = UserEntity(
        name: "", email: "nizar10@gmail.com", password: "nizarnizar");

    //BlocProvider.of<AuthBloc>(context).add(LoginEvent(user: user));
    //FirebaseAuth.instance.signInWithEmailAndPassword(
    // email: "nizar10@gmail.com", password: "nizarnizar");
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(user: user1));

    //}
  }

  @override
  bool get wantKeepAlive => true;
}
