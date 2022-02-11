import 'package:flutter/material.dart';

class PinCurvedWidget extends StatelessWidget {
  final Widget child;
  final double curvedDistance;
  final double curvedHeight;

  const PinCurvedWidget(
      {Key? key, 
      this.curvedDistance = 25, 
      this.curvedHeight = 25, 
      required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedWidgetBackgroundClipper(
        curvedDistance: curvedDistance, 
        curvedHeight: curvedHeight),
      child: child,
    );
  }
}

class CurvedWidgetBackgroundClipper extends CustomClipper<Path> {
  final double curvedDistance;
  final double curvedHeight;

  CurvedWidgetBackgroundClipper({required this.curvedDistance, required this.curvedHeight});
  
  @override
  getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.lineTo(size.width, 0);
    clippedPath.lineTo(size.width, size.height - curvedDistance - curvedHeight);
    clippedPath.quadraticBezierTo(size.width, size.height - curvedHeight, size.width - curvedDistance, size.height - curvedHeight);
    clippedPath.lineTo(curvedDistance, size.height - curvedHeight);
    clippedPath.quadraticBezierTo(0, size.height - curvedHeight, 0, size.height - curvedDistance - curvedHeight);
    clippedPath.lineTo(0, 0);   

    return clippedPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
  
}