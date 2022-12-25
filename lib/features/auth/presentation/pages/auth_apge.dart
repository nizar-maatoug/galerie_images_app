import 'package:flutter/material.dart';
import 'package:galerie_images_app/features/auth/presentation/widgets/auth_btn.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Partager des photos avec vos amis",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/logo.png'))),
                ),
                const Text(
                  "Galerie images",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                    text: "Login",
                    onPressed: () {
                      GoRouter.of(context).pushNamed('login');
                    },
                    color: Colors.blue),
                const SizedBox(
                  height: 20,
                ),
                AuthButton(
                    text: "Register",
                    onPressed: () {
                      GoRouter.of(context).goNamed("register");
                    },
                    color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
