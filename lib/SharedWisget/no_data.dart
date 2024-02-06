import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  NoData({Key? key, this.message = 'No data available'}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(message),
      ),
    );
  }
}
