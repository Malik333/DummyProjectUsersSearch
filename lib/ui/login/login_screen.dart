import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_state.dart';
import 'package:dummy_project_users_search/ui/home/home_screen.dart';
import 'package:dummy_project_users_search/utils/regex.dart';

import '../../bloc/auth/auth_event.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyUsername = GlobalKey<FormBuilderState>();
  final _formKeyPassword = GlobalKey<FormBuilderState>();
  late AuthenticationBloc bloc;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isLoginButtonEnabled = true;
  bool isErrorOccurred = false;
  String errorMessage = '';
  bool isEmpty = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AuthenticationBloc>(context);
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {

                  if (state is AuthenticationAuthenticated) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(HomeScreen.route, (Route<dynamic> route) => false);
                    });
                    isLoginButtonEnabled = true;
                  }
                  if (state is ErrorAuthenticationState) {
                    errorMessage = state.error;
                    isErrorOccurred = true;
                    isLoginButtonEnabled = true;

                    _formKeyPassword.currentState!.validate();
                  }

                  if (state is AuthenticationInProgress) {
                    isLoginButtonEnabled = false;
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_circle_outlined, size: 100,),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sign in to continue', style: TextStyle(fontSize: 12, color: Colors.grey),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                        child: FormBuilder(
                          key: _formKeyUsername,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              isEmpty = false;
                              if (value!.isEmpty) {
                                isEmpty = true;
                                return 'Please enter your username';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              labelText: 'Enter your username',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                        child: FormBuilder(
                          key: _formKeyPassword,
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              isEmpty = false;

                              if (value!.isEmpty) {
                                isEmpty = true;
                                return 'Please enter your password';
                              }

                              if (isErrorOccurred) {
                                return errorMessage;
                              }

                              return null;
                            },
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              labelText: 'Enter your password',
                              prefixIcon: Icon(Icons.lock_outlined),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: !isLoginButtonEnabled ? null :  () {
                            _formKeyUsername.currentState!.validate();
                            _formKeyPassword.currentState!.validate();

                            if (!isEmpty) {
                              isErrorOccurred = false;
                              bloc.add(LoginRequested(emailController.text, passwordController.text));
                            }
                          },
                          child: Text('Login'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18),),
                        ),
                      ),
                    ],
                  );
                }, listener: (context, state) {
                  print('listener');
              },
              ),
            ),
          ),
        ),
      ),
    );
  }
}