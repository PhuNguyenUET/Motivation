import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/screens/TopicsScreen/topic_tile.dart';
import 'package:motivation/screens/CollectionScreen/user_created_category_controller.dart';
import 'package:provider/provider.dart';

import '../../models/quote.dart';
import '../../models/tag.dart';
import '../UtilityScreens/loading.dart';

class CollectionAdditionScreen extends StatefulWidget {
  Quote currentQuote = Quote(id: 0, quote: '');
  CollectionAdditionScreen({super.key, required this.currentQuote});

  @override
  State<CollectionAdditionScreen> createState() => _CollectionAdditionScreenState();
}

class _CollectionAdditionScreenState extends State<CollectionAdditionScreen> {
  List<String> categories = [];
  String search = "";

  @override
  Widget build(BuildContext context) {
    var userCateState = Provider.of<UserCreatedCategoryController>(context, listen: true);

    return FutureBuilder<List<String>>(
        future: userCateState.getCategories(search),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            categories = snapshot.data!;
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
          }
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text('Add to collection',
              style: TextStyle(fontSize: 20),),
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
                                    print(categories[index]);
                                    await userCateState.insertQuoteIntoCate(widget.currentQuote.id!, categories[index]);
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
                  : Expanded(child: Loading()),
            ],
          );
        });
  }
}
