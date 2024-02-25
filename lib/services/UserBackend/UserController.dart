import 'package:motivation/services/UserBackend/UserService.dart';

import '../../models/user.dart';

class UserController {
  static UserService? _userService;

  UserController._create();

  static Future<UserController> create() async {
    _userService = await UserService.create();

    return UserController._create();
  }

  String? getName() {
    return _userService!.getName();
  }

  int? getBackgroundId() {
    return _userService!.getBackgroundId();
  }

  int? getFontId() {
    return _userService!.getFontId();
  }

  Future<String> updateName(String name) async {
    if(name.isEmpty) {
      return "Name cannot be set as empty";
    } else {
      return await _userService!.updateName(name);
    }
  }

  Future<String> updateBackgroundId(int backgroundId) async {
    return await _userService!.updateBackgroundId(backgroundId);
  }

  Future<String> updateFontId(int fontId) async {
    return await _userService!.updateFontId(fontId);
  }
}