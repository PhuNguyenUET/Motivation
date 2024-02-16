import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/font_tile.dart';
import 'package:provider/provider.dart';

import '../decor_controller.dart';

class AllFonts extends StatelessWidget {
  const AllFonts({super.key});

  @override
  Widget build(BuildContext context) {
    var decorState = Provider.of<DecorController>(context, listen:true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: AnimationLimiter(
            child: GridView.builder(
                cacheExtent: 9999,
                itemCount: 30,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 1),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 475),
                      columnCount: 3,
                      child: ScaleAnimation(
                          child: FadeInAnimation(
                              child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => {
                                        decorState.fontIndex = index,
                                        Navigator.pop(context)
                                      },
                                  child: FontTile(font: 'Font$index')))));
                }),
          ),
        ),
      ),
    );
  }
}
