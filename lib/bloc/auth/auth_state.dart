
import 'package:flutter/material.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';

@immutable
abstract class AuthenticationState {
}

class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated({required this.userModel});

  final UserModel userModel;
}

class ErrorAuthenticationState extends AuthenticationState {
  final String error;
  ErrorAuthenticationState(this.error);
}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationFailedAuthenticated extends AuthenticationState {}

class AuthenticationTimedOutState extends AuthenticationUnauthenticated {}

class AuthenticationInitial extends AuthenticationState {}