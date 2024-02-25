import 'package:motivation/services/UserBackend/UserController.dart';

import '../models/user.dart';

class UserIntegration {
  static UserController? _userController;

  static final UserIntegration _instance = UserIntegration._create();

  UserIntegration._create();

  static Future<UserIntegration> create() async {
    _userController ??= await UserController.create();

    return _instance;
  }

  String? getName() {
    return _userController!.getName();
  }

  int? getBackgroundId() {
    return _userController!.getBackgroundId();
  }

  int? getFontId() {
    return _userController!.getFontId();
  }

  Future<String> updateName(String name) async {
    if(!RegExp(r'^[A-Za-z0-9_]+$').hasMatch(name)) {
      return "Name can only contain number, letter and underscore";
    } else {
      return await _userController!.updateName(name);
    }
  }

  Future<String> updateBackgroundId(int backgroundId) async {
    return await _userController!.updateBackgroundId(backgroundId);
  }

  Future<String> updateFontId(int fontId) async {
    return await _userController!.updateFontId(fontId);
  }
}