import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen {
  OverlayEntry loadingOverlay = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
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
  );
}
