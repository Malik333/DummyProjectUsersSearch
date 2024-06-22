import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_bloc.dart';
import 'package:dummy_project_users_search/bloc/user/user_bloc.dart';
import 'package:dummy_project_users_search/ui/home/home_screen.dart';
import 'package:dummy_project_users_search/ui/login/login_screen.dart';
import 'package:dummy_project_users_search/ui/profile/profile_screen.dart';
import 'package:dummy_project_users_search/ui/splash/splash_screen.dart';

class RouteGenerator {

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
              child: const SplashScreen(),
            );
          },
        );
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider<AuthenticationBloc>(
                create: (context) => AuthenticationBloc(),
                child: const LoginScreen(),
              ),
        );
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
              child: HomeScreen(),
            );
          },
        );
      case ProfileScreen.route:
        return MaterialPageRoute(
          builder: (_) =>
              MultiBlocProvider(
                providers: [
                  BlocProvider<UserProfileBloc>(
                    create: (context) => UserProfileBloc(),
                  ),
                  BlocProvider<AuthenticationBloc>(
                    create: (context) => AuthenticationBloc(),
                  ),
                ],
                child: const ProfileScreen(),
              ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}
