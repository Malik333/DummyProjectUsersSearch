import 'package:flutter/material.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';

@immutable
abstract class AuthenticationEvent {
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class RefreshLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  RefreshLoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthenticationEvent {}