import 'package:flutter/material.dart';
import 'package:motivation/main.dart';
import 'package:provider/provider.dart';

import '../decor_controller.dart';

class FontTile extends StatelessWidget {
  final String font;

  FontTile( {super.key, required this.font} );

  @override
  Widget build(BuildContext context) {
    var decorState = Provider.of<DecorController>(context, listen:true);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage('assets/wallpaper_${decorState.backgroundIndex}.jpg'),
                  fit: BoxFit.cover,
                )
            ),
            height: 70,
            width: 140,
            child: Center(
              child: Text(
                'Aa',
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: font,
                    color: Colors.white,
                ),
              ),
            ),
          )
      ),
    );
  }
}
