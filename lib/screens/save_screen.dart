import 'dart:typed_data';

import 'package:flutter/material.dart';

class Saver extends StatelessWidget {
  Uint8List img;

  Saver( {super.key, required this.img} );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
              child: ClipRRect(
              child: Image.memory(img),
              )
          ),
        ),
        SizedBox(height: 20,),
        Row(

        )
      ],
    );
  }
}
