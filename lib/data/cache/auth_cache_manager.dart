import 'dart:convert';

import 'package:dummy_project_users_search/data/enum/auth_user_enum.dart';
import 'package:dummy_project_users_search/data/model/credentials_model.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';

import 'cache_manager.dart';

class AuthCacheManager {
  Future<bool> isLoggedIn() async {
    return (await CacheManager.getBool(AuthUserEnum.login.name)) ?? false;
  }

  Future<void> signOut() async {
    await CacheManager.clearAll();
  }

  Future<void> updateLoggedIn(bool isLoggedIn) async {
    await CacheManager.setBool(AuthUserEnum.login.name, isLoggedIn);
  }

  Future<void> updateToken(String? token) async {
    if (token != null) {
      await CacheManager.setString(AuthUserEnum.token.name, token);
    } else {
      if (await CacheManager.containsKey(AuthUserEnum.token.name)) {
        await CacheManager.remove(AuthUserEnum.token.name);
      }
    }
  }

  Future<String?> getToken() async {
    if (await CacheManager.containsKey(AuthUserEnum.token.name)) {
      final token = await CacheManager.getString(AuthUserEnum.token.name);
      return token;
    }
    return null;
  }

  Future<void> updateTokenFromStorage() async {
    if (await CacheManager.containsKey(AuthUserEnum.token.name)) {
      final token = await CacheManager.getString(AuthUserEnum.token.name);
    }
  }

  Future<void> setUserImage(String? image) async {
    if (image != null) {
      await CacheManager.setString(AuthUserEnum.image.name, image);
    } else {
      if (await CacheManager.containsKey(AuthUserEnum.image.name)) {
        await CacheManager.remove(AuthUserEnum.image.name);
      }
    }
  }

  Future<String?> getUSerImage() async {
    if (await CacheManager.containsKey(AuthUserEnum.image.name)) {
      final image = await CacheManager.getString(AuthUserEnum.image.name);
      return image;
    }
    return null;
  }

  Future<void> setUserCredentials(CredentialsModel credentialsModel) async {
    await CacheManager.setString(AuthUserEnum.credentials.name, jsonEncode(credentialsModel.toJson()));
  }

  Future<CredentialsModel?> getUserCredentials() async {
    if (await CacheManager.containsKey(AuthUserEnum.credentials.name)) {
      final credentials = await CacheManager.getString(AuthUserEnum.credentials.name);
      return CredentialsModel.fromJson(jsonDecode(credentials!));
    }
    return null;
  }

  Future<void> setUser(UserModel userModel) async {
    await CacheManager.setString(AuthUserEnum.user.name, jsonEncode(userModel.toJson()));
  }

  Future<UserModel?> getUser() async {
    if (await CacheManager.containsKey(AuthUserEnum.user.name)) {
      final user = await CacheManager.getString(AuthUserEnum.user.name);
      return UserModel.fromJson(jsonDecode(user!));
    }
    return null;
  }
}