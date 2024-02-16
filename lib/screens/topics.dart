import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/topic_tile.dart';
import 'package:motivation/utilities/hex_color.dart';
import '../models/tag.dart';
import '../constants/gradient_button.dart';

class Topics extends StatelessWidget {
  const Topics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UnicornOutlineButton(
            strokeWidth: 4,
            radius: 16,
            gradient: LinearGradient(
              colors: [HexColor('#D8B5FF'), HexColor('#1EAE98')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            child: Expanded(
                child: Center(
                    child: Text('Make your own mix',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300)))),
            onPressed: () {},
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: TopicTile(
                          tag: Tag(tag: 'Love', icon: Symbols.favorite_border),
                        )),
                    Expanded(
                        flex: 1,
                        child: TopicTile(
                          tag: Tag(tag: 'Smile', icon: Symbols.abc),
                        ))
                  ],
                );
              }),
        ],
      ),
    );
  }
}
