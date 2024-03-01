import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:motivation/screens/Notification/category_tile.dart';
import 'package:motivation/screens/Notification/reminder_screen_controller.dart';
import 'package:motivation/screens/UtilityScreens/loading.dart';
import 'package:provider/provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  String currentCategory = '';
  List<String> categoryList = [];

  @override
  Widget build(BuildContext context) {
    var reminderState = Provider.of<ReminderController>(context, listen: true);

    Future<void> initInstance() async {
      if (currentCategory.isEmpty) {
        currentCategory = await reminderState.getCategory();
      }
      if (categoryList.isEmpty) {
        categoryList = await reminderState.getAllCategories();
        print(categoryList.length);
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                Navigator.pop(context);
              }
            },
            child: FutureBuilder<void>(
                future: initInstance(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if(snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Select category',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: snapshot.connectionState == ConnectionState.done
                            ? AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: categoryList.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 700),
                                        child: SlideAnimation(
                                          verticalOffset: 500.0,
                                          child: FadeInAnimation(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3.0,
                                                        horizontal: 4.0),
                                                child: CategoryTile(
                                                  category: categoryList[index],
                                                  isSelected:
                                                      categoryList[index] ==
                                                          currentCategory,
                                                  onPress: () {
                                                    setState(() {
                                                      currentCategory =
                                                          categoryList[index];
                                                    });
                                                  },
                                                )),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : Loading(),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await reminderState.setCategory(currentCategory);
                          Navigator.pop(context);
                          },
                        child: Text("Save"),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                })));
  }
}
