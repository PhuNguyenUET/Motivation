import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motivation/utilities/hex_color.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.grey,
            size: 40.0,
          ),
        ),
      ),
    );
  }
}