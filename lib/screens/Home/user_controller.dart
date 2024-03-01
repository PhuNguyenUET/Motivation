import 'package:flutter/material.dart';
import 'package:motivation/screens/Home/quote_integration.dart';
import 'package:motivation/screens/Home/user_integration.dart';

import '../../models/quote.dart';

class DecorController extends ChangeNotifier {
  UserIntegration? _backend;

  Future<void> initUserIntegration() async {
    print('Init finished');
    _backend ??= await UserIntegration.create();
  }

  int? _fontIndex;

  int getFontIndex() {
    _fontIndex ??= _backend!.getFontId();
    return _fontIndex!;
  }
  Future<void> setFontIndex(int fontId) async {
    _fontIndex = fontId;
    await _backend!.updateFontId(fontId);
    notifyListeners();
  }

  int? _backgroundIndex;
  int getBackgroundIndex() {
    _backgroundIndex ??= _backend!.getBackgroundId();
    return _backgroundIndex!;
  }
  Future<void> setBackgroundIndex(int backgroundId) async {
    _backgroundIndex = backgroundId;
    await _backend!.updateBackgroundId(backgroundId);
    notifyListeners();
  }

  String? _name = 'User';
  String getName() {
    _name ??= _backend!.getName();
    return _name!;
  }
  Future<void> setName(String name) async {
    _name = name;
    await _backend!.updateName(name);
    notifyListeners();
  }
}
