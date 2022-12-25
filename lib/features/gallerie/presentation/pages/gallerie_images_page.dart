import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galerie_images_app/features/auth/presentation/bloc/auth/auth_bloc.dart';

class GallerieImagePage extends StatelessWidget {
  const GallerieImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galerie images"),
        actions: [
          IconButton(
              onPressed: () {
                
                BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Container(
        child: const Text('Galerie image page'),
      ),
    );
  }
}
