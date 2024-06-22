import 'package:flutter/material.dart';

class SkeletonShimmer extends StatefulWidget {
  SkeletonShimmer({Key? key, this.height, this.width, this.radius = 16}) : super(key: key);

  final double? height, width, radius;

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer> with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = ColorTween(
      begin: Colors.black12,
      end: Colors.black26,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat(reverse: true);
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: animation.value,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.radius!),
        ),
      ),
    );
  }
}

class CircleSkeleton extends StatefulWidget {
  CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  State<CircleSkeleton> createState() => _CircleSkeletonState();
}

class _CircleSkeletonState extends State<CircleSkeleton> with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = ColorTween(
      begin: Colors.black12,
      end: Colors.black26,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat(reverse: true);
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        color: animation.value,
        shape: BoxShape.circle,
      ),
    );
  }
}

class BoxSkeleton extends StatefulWidget {
  BoxSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  State<BoxSkeleton> createState() => _BoxSkeletonState();
}

class _BoxSkeletonState extends State<BoxSkeleton> with SingleTickerProviderStateMixin {

  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = ColorTween(
      begin: Colors.black12,
      end: Colors.black26,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat(reverse: true);
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        color: animation.value,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
