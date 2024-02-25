import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/main.dart';
import 'package:motivation/screens/font_tile.dart';
import 'package:provider/provider.dart';

import 'user_controller.dart';

class ThemeSelection extends StatefulWidget {

  ThemeSelection({super.key});

  @override
  State<ThemeSelection> createState() => _ThemeSelectionState();
}

class _ThemeSelectionState extends State<ThemeSelection> {

  List<AssetImage> images = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      images.add(AssetImage('assets/wallpaper_$i.jpg'));
    }
  }

  @override
  void dispose() {
    imageCache.clear();
    imageCache.clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var decorState = Provider.of<DecorController>(context, listen:true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
                'Change theme',
                style: TextStyle(
                    fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
            ),
            Expanded(child: SizedBox(width: double.infinity)),
            GestureDetector(
              onTap: () => {
                Navigator.pushReplacementNamed(context, '/allbg')
              },
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10.0,),
        SizedBox(
          height: 260.0,
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: 10,
              cacheExtent: 1000,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 700),
                  child: SlideAnimation(
                    horizontalOffset: 100.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            await decorState.setBackgroundIndex(index);
                            Navigator.pop(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              image: images[index],
                              fit: BoxFit.cover,
                              width: 140.0,
                              height: 260.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            Text(
              'Change font',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            Expanded(child: SizedBox(width: double.infinity)),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/allfonts');
              },
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10.0,),
        Column(
          children: [
            SizedBox(
              height: 160,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: 5,
                  cacheExtent: 1000,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: SlideAnimation(
                        horizontalOffset: 100.0,
                        child: FadeInAnimation(
                          child: Column(
                            children: [
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    await decorState.setFontIndex(index);;
                                    Navigator.pop(context);
                                  },
                                  child: FontTile(font: 'Font$index')
                              ),
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    await decorState.setFontIndex(index + 5);
                                    Navigator.pop(context);
                                  },
                                  child: FontTile(font: 'Font${index + 5}')
                              ),
                            ],
                          )
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
