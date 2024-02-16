import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motivation/utilities/hex_color.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
    );
  }
}