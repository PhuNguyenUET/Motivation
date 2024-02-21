import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotSaver {
  ScreenshotController screenshotController = ScreenshotController();

  Future<Uint8List> captureScreen(ImageProvider<Object> image, String quote, String author,
      String font) async {
    // Capture the screen
    Uint8List? capturedImage = await screenshotController.captureFromWidget(
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                quote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: font,
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              Text(
                author,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: font,
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return capturedImage;
  }
}