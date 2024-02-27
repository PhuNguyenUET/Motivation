import 'package:flutter/material.dart';
import 'package:motivation/models/tag.dart';
import 'package:motivation/screens/user_created_category_controller.dart';
import 'package:provider/provider.dart';

class TopicTileWithDelete extends StatelessWidget {
  final Tag tag;

  TopicTileWithDelete ( {super.key, required this.tag} );

  @override
  Widget build(BuildContext context) {
    var userCateState = Provider.of<UserCreatedCategoryController>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Row (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 25,),
                        Center(
                          child: Text(
                            tag.tag,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            softWrap: true,
                          ),
                        ),
                        Expanded(child: SizedBox(width: double.infinity,)),
                        IconButton(
                            onPressed: () async {
                              userCateState.deleteUserCategory(tag.tag);
                            },
                            icon: Icon(
                                Icons.delete_outline,
                              color: Colors.redAccent,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}
