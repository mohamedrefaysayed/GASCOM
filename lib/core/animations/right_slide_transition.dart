import 'package:flutter/material.dart';

class RightSlideTransition extends PageRouteBuilder {
  final Widget page;
  RightSlideTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin = const Offset(1, 0);
            Offset end = const Offset(0, 0);
            Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
            CurvedAnimation curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.decelerate,
            );
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
}
