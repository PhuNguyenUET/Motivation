import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:motivation/screens/loading.dart';
import 'package:motivation/screens/quotes_controller.dart';
import 'package:motivation/screens/topic_tile.dart';
import 'package:motivation/screens/topics_screen_controller.dart';
import 'package:motivation/utilities/hex_color.dart';
import 'package:provider/provider.dart';
import '../models/tag.dart';
import '../constants/gradient_button.dart';

class Topics extends StatefulWidget {
  const Topics({super.key});

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  List<String> categories = [];
  String search = "";

  @override
  Widget build(BuildContext context) {
    var quoteState = Provider.of<QuoteController>(context, listen: true);
    var topicsController = TopicsController();

    return FutureBuilder<List<String>>(
        future: topicsController.getCategoriesInSearch(search),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            categories = snapshot.data!;
            print(categories.length);
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
          }
          return Column(
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onSubmitted: (val) {
                    setState(() {
                      search = val;
                      print(search);
                    });
                  },
                  leading: const Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              snapshot.connectionState == ConnectionState.done
                  ? Expanded(
                      child: AnimationLimiter(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: categories.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 7 / 4),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 700),
                                child: SlideAnimation(
                                  verticalOffset: 100.0,
                                  child: FadeInAnimation(
                                      child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      await quoteState
                                          .setCategory(categories[index]);
                                      print(quoteState.category);
                                      Navigator.pop(context);
                                    },
                                    child: TopicTile(
                                      tag: Tag(tag: categories[index]),
                                    ),
                                  )),
                                ),
                              );
                            }),
                      ),
                    )
                  : Loading(),
            ],
          );
        });
  }
}
