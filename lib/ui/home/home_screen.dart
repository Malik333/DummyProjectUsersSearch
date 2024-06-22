import "dart:async";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:dummy_project_users_search/bloc/auth/auth_bloc.dart";
import "package:dummy_project_users_search/bloc/auth/auth_event.dart";
import "package:dummy_project_users_search/bloc/auth/auth_state.dart";
import "package:dummy_project_users_search/data/cache/auth_cache_manager.dart";
import "package:dummy_project_users_search/data/model/user_model.dart";
import "package:dummy_project_users_search/ui/logs/logs_screen.dart";
import "package:dummy_project_users_search/ui/products/products_screen.dart";

class HomeScreen extends StatefulWidget {
  static const String route = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final AuthCacheManager cacheManager = AuthCacheManager();
  String? userAvatar;

  Timer? timer;
  AuthenticationBloc? authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    getUser();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getUser() async {
    final userImage = await cacheManager.getUSerImage();
    setState(() {
      userAvatar = userImage;
    });

    /*timer ??= Timer.periodic(const Duration(minutes: 10), (timer) async {
      var user = await cacheManager.getUserCredentials();
      if (user == null) return;
      authBloc!.add(LoginRequested(user.email, user.password));
    });*/
  }

  List<Widget> screens = [
    const ProductsScreen(),
    const LogsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("profile_screen");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: userAvatar != null
                        ? Image.network(userAvatar!)
                        : null),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Log',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
