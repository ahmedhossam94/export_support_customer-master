import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double width;
  Loader({Key? key, required this.color, this.width = 4.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: width,
      ),
    );
  }
}
