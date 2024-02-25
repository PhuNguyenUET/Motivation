import 'package:motivation/services/UserBackend/UserRepository.dart';

import '../../models/user.dart';

class UserService {
  static final _userRepository = UserRepository();
  static User? _user;

  UserService._create();

  static Future<UserService> create() async {
    _user = await _userRepository.getUser();

    return UserService._create();
  }

  String? getName() {
    return _user!.name;
  }

  int? getBackgroundId() {
    return _user!.backgroundId;
  }

  int? getFontId() {
    return _user!.fontId;
  }

  Future<String> updateName(String name) async {
    _user!.name = name;
    await _userRepository.updateUser(_user!);
    return "Name updated to $name";
  }

  Future<String> updateBackgroundId(int backgroundId) async {
    _user!.backgroundId = backgroundId;
    await _userRepository.updateUser(_user!);
    print("Background id updated to $backgroundId");
    return "Background id updated to $backgroundId";
  }

  Future<String> updateFontId(int fontId) async {
    _user!.fontId = fontId;
    await _userRepository.updateUser(_user!);
    return "Font id updated to $fontId";
  }
}