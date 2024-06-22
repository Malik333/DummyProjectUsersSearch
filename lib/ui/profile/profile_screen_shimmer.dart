import 'package:flutter/material.dart';
import 'package:dummy_project_users_search/utils/shimmer/skeleton_shimmer_widget.dart';

class ProfileScreenShimmer extends StatefulWidget {
  static const String route = "profile_screen";

  const ProfileScreenShimmer({Key? key}) : super(key: key);

  @override
  State<ProfileScreenShimmer> createState() => _ProfileScreenShimmerState();
}

class _ProfileScreenShimmerState extends State<ProfileScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 150,
              color: Colors.green,
              child: Center(
                child: CircleSkeleton(
                  size: 100,
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
                        SkeletonShimmer(
                          width: 200,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonShimmer(
                          width: 200,
                        ),
                      ]),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonShimmer(
                          width: 200,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonShimmer(
                          width: 200,
                        ),
                      ]),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonShimmer(
                          width: 200,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonShimmer(
                          width: 200,
                        ),
                      ]),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonShimmer(
                          width: 200,
                        ),
                        SizedBox(height: 4,),
                        SkeletonShimmer(
                          width: 200,
                        ),
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
