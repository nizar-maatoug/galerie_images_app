import 'package:flutter/material.dart';
import 'package:galerie_images_app/core/pages/page_not_found.dart';
import 'package:galerie_images_app/features/auth/presentation/pages/auth_apge.dart';
import 'package:galerie_images_app/features/auth/presentation/pages/login_page.dart';
import 'package:galerie_images_app/features/auth/presentation/pages/register_page.dart';
import 'package:galerie_images_app/features/auth/presentation/pages/update_user_page.dart';
import 'package:galerie_images_app/features/gallerie/presentation/pages/gallerie_images_page.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  // final AuthBloc authBloc;

  //AppRouter(this.authBloc);
  AppRouter();

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'authentication',
        builder: (context, state) {
          return AuthPage();
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return RegisterPage();
        },
      ),
      GoRoute(
        path: '/update',
        name: 'update_user',
        builder: (context, state) {
          return UpdateUserPage();
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: LoginPage(key: state.pageKey),
          );
        },
      ),
      GoRoute(
          path: '/galerie',
          name: 'galerie',
          builder: (context, state) {
            return GallerieImagePage();
          }),
    ],
    errorBuilder: (context, state) => PageNotFound(),
    /*redirect: (context, state) {
      final bool unauthenticated = authBloc.state is UnAuthenticatedState;
      final bool authenticated = authBloc.state is AuthenticatedState;

      final bool isGaleriePage = (state.subloc == '/galerie');

      /*if (unauthenticated) {
        return isGaleriePage ? '/' : null;
      }*/
    },*/
    //refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

/*class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}*/
