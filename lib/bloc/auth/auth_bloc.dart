import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_project_users_search/data/cache/auth_cache_manager.dart';
import 'package:dummy_project_users_search/data/model/credentials_model.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';
import 'package:dummy_project_users_search/repository/auth/auth_repo_imp.dart';

import '../../data/remote/api_exception.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final authRepo = AuthRepoImp();
  final authCacheManager = AuthCacheManager();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoginRequested>(_loginUser);
    on<RefreshLoginRequested>(_refreshLoginUser);

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(AuthenticationUnauthenticated());
      } catch (_) {}
    });
  }

  FutureOr<void> _loginUser(
      LoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      var userData = await authRepo.login(email: event.email, password: event.password);
      print('user: $userData');
      UserModel response = UserModel.fromJson(userData);
      if (response.token != null) {
        await authCacheManager.updateToken(response.token);
        await authCacheManager.setUserImage(response.image);
        await authCacheManager.setUserCredentials(CredentialsModel(email: event.email, password: event.password));
        await authCacheManager.updateLoggedIn(true);
        emit(AuthenticationAuthenticated(userModel: response));
      } else {
        // emit(ErrorAuthenticationState(response.message));
      }
    } catch (e) {
      emit(ErrorAuthenticationState(e.toString()));
    }
  }

  FutureOr<void> _refreshLoginUser(
      RefreshLoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      var userData = await authRepo.login(email: event.email, password: event.password);
      print('user: $userData');
      UserModel response = UserModel.fromJson(userData);
      if (response.token != null) {
        await authCacheManager.updateToken(response.token);
        await authCacheManager.setUserImage(response.image);
        await authCacheManager.setUserCredentials(CredentialsModel(email: event.email, password: event.password));
        await authCacheManager.updateLoggedIn(true);
        emit(AuthenticationAuthenticated(userModel: response));
      } else {
        // emit(ErrorAuthenticationState(response.message));
      }
    } on UnauthorisedException catch (e) {
      emit(AuthenticationFailedAuthenticated());
    }
    catch (e) {
      emit(ErrorAuthenticationState(e.toString()));
    }
  }
}
