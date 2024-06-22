import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_event.dart';
import 'package:dummy_project_users_search/bloc/user/user_bloc.dart';
import 'package:dummy_project_users_search/bloc/user/user_state.dart';
import 'package:dummy_project_users_search/ui/login/login_screen.dart';
import 'package:dummy_project_users_search/ui/profile/profile_screen_shimmer.dart';

import '../../bloc/auth/auth_state.dart';
import '../../bloc/user/user_event.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = "profile_screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfileBloc _userProfileBloc;
  late AuthenticationBloc _authBloc;

  @override
  initState() {
    super.initState();
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _userProfileBloc.add(UserProfileFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return ProfileScreenShimmer();
          }

          if (state is UserProfileError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is UserProfileLoaded) {
            var userModel = state.userModel;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 150,
                      color: Colors.green,
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(userModel.image!),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Full Name',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '${userModel.firstName} ${userModel.lastName}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${userModel.email}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${userModel.gender}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Age',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${userModel.age}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              _authBloc.add(LogoutRequested());
                            },
                            child: Text(
                              'Sign out'.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                    return Container();
                  }, listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.route, (route) => false);
                    }
                  }),
                ],
              ),
            );
          }

          return Container();
        },
        listener: (BuildContext context, UserProfileState state) {},
      ),
    );
  }
}
