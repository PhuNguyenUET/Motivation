import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'collection_add_pop_up.dart';

class FloatingAddCollectionButton extends StatelessWidget {
  const FloatingAddCollectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => const CollectionAddPopUp(),
          width: MediaQuery.of(context).size.width - 20,
          height: 210,
          radius: 25,
          direction: PopoverDirection.top,
        );
      },
      foregroundColor: Colors.white,
      backgroundColor: Colors.lightBlueAccent,
      shape: CircleBorder(),
      child: Icon(Icons.add),
    );
  }
}
