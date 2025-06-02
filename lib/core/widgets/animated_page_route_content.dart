import 'package:flutter/material.dart';

Animation<Offset> _buildDrive(BuildContext context) {
  return ModalRoute.of(context)!.animation!.drive(
        Tween(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
      );
}

class AnimatedPageRouteContent extends StatelessWidget {
  final Widget child;

  const AnimatedPageRouteContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: ModalRoute.of(context)!.animation!,
      child: SlideTransition(
        position: _buildDrive(context),
        child: child,
      ),
    );
  }
}
