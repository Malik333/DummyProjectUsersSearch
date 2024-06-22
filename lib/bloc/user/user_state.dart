import 'package:flutter/material.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';

@immutable
abstract class UserProfileState {
}

class UserProfileInitial extends UserProfileState {}
class UserProfileLoading extends UserProfileState {}
class UserProfileLoaded extends UserProfileState {
  final UserModel userModel;
  UserProfileLoaded(this.userModel);
}

class UserProfileError extends UserProfileState {
  final String error;
  UserProfileError(this.error);
}