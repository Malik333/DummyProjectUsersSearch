
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_project_users_search/bloc/user/user_event.dart';
import 'package:dummy_project_users_search/bloc/user/user_state.dart';
import 'package:dummy_project_users_search/data/model/user_model.dart';
import 'package:dummy_project_users_search/repository/profile/profile_repo_imp.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final _userRepo = ProfileRepoImp();

  UserProfileBloc() : super(UserProfileInitial()){
    on<UserProfileFetch>((event, emit) async {
      emit(UserProfileLoading());
      try {
        var userData = await _userRepo.fetchProfile();
        emit(UserProfileLoaded(UserModel.fromJson(userData)));
      } catch (e) {
        emit(UserProfileError(e.toString()));
      }
    });
  }
}