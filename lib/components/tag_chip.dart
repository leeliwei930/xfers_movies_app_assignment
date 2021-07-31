import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {

  final Widget child;
  final Color outlineColor;
  final Color backgroundColor;
  TagChip({required this.child, required this.outlineColor, this.backgroundColor = Colors.transparent});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: outlineColor),
        borderRadius: BorderRadius.all(Radius.circular(3.5)),
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: child,
    );
  }
}
