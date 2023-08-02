import 'package:flutter/material.dart';

class LeftArrowWidget extends StatefulWidget {
  const LeftArrowWidget({Key? key}) : super(key: key);

  @override
  LeftArrowWidgetState createState() => LeftArrowWidgetState();
}

class LeftArrowWidgetState extends State<LeftArrowWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _offsetController;
  late final Animation<Offset> _offsetAnimation;
  late final Tween<Offset> _tween;

  final _defaultAnimationDuration = const Duration(seconds: 1);
  final _defaultTweenEnd = const Offset(.02, 0);

  @override
  void initState() {
    super.initState();
    _tween = Tween<Offset>(
      begin: _defaultTweenEnd,
      end: Offset.zero,
    );
    _offsetController = AnimationController(
      vsync: this,
      duration: _defaultAnimationDuration,
    )..repeat(reverse: true);
    _offsetAnimation = _tween.animate(
      CurvedAnimation(
        parent: _offsetController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 1000,
      margin: const EdgeInsets.fromLTRB(5.0, 30.0, 10.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromARGB(255, 0, 102, 255),
      ),
      child: Center(
        child: Wrap(
          children: [
            SlideTransition(
                position: _offsetAnimation,
                child: Image.asset('assets/images/left.png'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }
}




class RightArrowWidget extends StatefulWidget {
  const RightArrowWidget({Key? key}) : super(key: key);

  @override
  RightArrowWidgetState createState() => RightArrowWidgetState();
}

class RightArrowWidgetState extends State<RightArrowWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _offsetController;
  late final Animation<Offset> _offsetAnimation;
  late final Tween<Offset> _tween;

  final _defaultAnimationDuration = const Duration(seconds: 1);
  final _defaultTweenEnd = const Offset(.02, 0);

  @override
  void initState() {
    super.initState();
    _tween = Tween<Offset>(
      begin: Offset.zero,
      end: _defaultTweenEnd,
    );
    _offsetController = AnimationController(
      vsync: this,
      duration: _defaultAnimationDuration,
    )..repeat(reverse: true);
    _offsetAnimation = _tween.animate(
      CurvedAnimation(
        parent: _offsetController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 1000,
      margin: const EdgeInsets.fromLTRB(5.0, 30.0, 10.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromARGB(255, 0, 102, 255),
      ),
      child: Center(
        child: Wrap(
          children: [
            SlideTransition(
                position: _offsetAnimation,
                child: Image.asset('assets/images/right.png'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }
}
