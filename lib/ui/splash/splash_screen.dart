import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_event.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_state.dart';
import 'package:dummy_project_users_search/data/model/credentials_model.dart';
import 'package:dummy_project_users_search/ui/login/login_screen.dart';

import '../../data/cache/auth_cache_manager.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var authManager = AuthCacheManager();
  AuthenticationBloc? authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthenticationBloc>(context);

    Timer(const Duration(seconds: 1), () async {
      CredentialsModel? credentialsModel =
          await authManager.getUserCredentials();
      if (credentialsModel != null) {
        authBloc!.add(
            LoginRequested(credentialsModel.email, credentialsModel.password));
      } else {
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(LoginScreen.route);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return Container();
              }, listener: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            HomeScreen.route, (Route<dynamic> route) => false);
                  });
                }

                if (state is ErrorAuthenticationState) {
                  authBloc!.add(LogoutRequested());
                }

                if (state is AuthenticationUnauthenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(
                            LoginScreen.route, (Route<dynamic> route) => false);
                  });
                }
              }),
              Image.asset('assets/images/search.png'),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Dummy search',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
