import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CategoryTile extends StatefulWidget {
  String category;
  Stream? cateStream;
  String? currentSelectedCate;
  void Function()? onPress;
  CategoryTile({super.key, required this.category, required this.cateStream, required this.currentSelectedCate, required this.onPress});

  @override
  State<CategoryTile> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryTile> {
  String? _currentSelectedid;

  StreamSubscription? _cateSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSelectedid = widget.currentSelectedCate;
    _initStreams();
  }

  @override
  void dispose() {
    _cateSubscription?.cancel();
    super.dispose();
  }

  void _initStreams() {
    _cateSubscription = widget.cateStream!.listen((event) {
      setState(() {
        _currentSelectedid = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Card(
        shape: widget.category == _currentSelectedid  ? RoundedRectangleBorder(
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
              IconButton(onPressed: widget.onPress, icon: widget.category == _currentSelectedid ? Icon(Icons.check_circle_outline,) : Icon(Icons.circle_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
