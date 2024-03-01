import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/screens/CollectionScreen/FloatingAddCollectionButton.dart';
import 'package:motivation/screens/CollectionScreen/collection_add_pop_up.dart';
import 'package:motivation/screens/TopicsScreen/topic_tile.dart';
import 'package:motivation/screens/CollectionScreen/topic_tile_with_delete.dart';
import 'package:motivation/screens/CollectionScreen/user_created_category_controller.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

import '../../models/tag.dart';
import '../UtilityScreens/loading.dart';

class UserCollectionScreen extends StatefulWidget {
  const UserCollectionScreen({super.key});

  @override
  State<UserCollectionScreen> createState() => _UserCollectionScreenState();
}

class _UserCollectionScreenState extends State<UserCollectionScreen> {
  List<String> categories = [];
  String search = "";

  @override
  Widget build(BuildContext context) {
    var userCateState = Provider.of<UserCreatedCategoryController>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        floatingActionButton: FloatingAddCollectionButton(),
        body: SafeArea(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  Navigator.pop(context);
                }
              },
              child: FutureBuilder<List<String>>(
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
                                              //TODO: Add function
                                              userCateState.currentCategory = categories[index];
                                              Navigator.pushNamed(context, '/quoteInCate');
                                            },
                                            child: TopicTileWithDelete(
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
                  }),
            )
        )
    );
  }
}
