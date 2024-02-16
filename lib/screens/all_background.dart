import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/main.dart';
import 'package:provider/provider.dart';

import '../decor_controller.dart';

class AllBackground extends StatefulWidget {
  const AllBackground({super.key});

  @override
  State<AllBackground> createState() => _AllBackgroundState();
}

class _AllBackgroundState extends State<AllBackground> {
  List<Image> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 20; i++) {
      images.add(Image.asset(
        'assets/wallpaper_$i.jpg',
        fit: BoxFit.cover, // Fixes border issues
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    imageCache.clear();
    imageCache.clearLiveImages();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    for (int i = 0; i < 20; i++) {
      precacheImage(images[i].image, context);
    }
  }

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
                cacheExtent: 1000,
                itemCount: 20,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1 / 2),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 475),
                    columnCount: 3,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => {
                              decorState.backgroundIndex = index,
                              Navigator.pop(context)
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: images[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
