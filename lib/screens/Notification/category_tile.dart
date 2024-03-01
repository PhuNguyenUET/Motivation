import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryTile extends StatefulWidget {
  String category;
  bool isSelected;
  void Function()? onPress;
  CategoryTile({super.key, required this.category, required this.isSelected, required this.onPress});

  @override
  State<CategoryTile> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Card(
        shape: widget.isSelected ? RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blueAccent,
          )
        ) : RoundedRectangleBorder(),
        elevation: 1.0,
        child: ListTile(
          title: Text(widget.category),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: widget.onPress, icon: widget.isSelected ? Icon(Icons.check_circle_outline,) : Icon(Icons.circle_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
