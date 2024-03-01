import 'package:flutter/material.dart';
import 'package:motivation/screens/CollectionScreen/user_created_category_controller.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

class CollectionAddPopUp extends StatefulWidget {
  const CollectionAddPopUp({super.key});

  @override
  State<CollectionAddPopUp> createState() => _CollectionAddPopUpState();
}

class _CollectionAddPopUpState extends State<CollectionAddPopUp> {
  String collectionName = '';
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    errorMessage = '';
    var userCateState = Provider.of<UserCreatedCategoryController>(context, listen: true);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text(
            'Add new collection',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: Constants.textInputDecoration.copyWith(
                  labelText: 'Collection',
              ),
              maxLines: null,
              validator: (val) {
                if (errorMessage.isNotEmpty) {
                  return errorMessage;
                } else {
                  return null;
                }
              },
              onChanged: (val) {
                setState(() {
                  collectionName = val;
                });
              },
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () async {
              String msg = await userCateState.insertUserCategory(collectionName);
              print(msg);
              if (msg.isNotEmpty) {
                errorMessage = msg;
                _formKey.currentState!.validate();
              }
              if (msg.isEmpty) {
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            ),
          )
        ],
      ),
    );
  }
}
