import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Provider to manage the login acctions
class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  //Save the login username into storage
  void login(String username, String password) {
    _isAuthenticated = true;
    _storage.write(key: 'isAuthenticated', value: 'true');
    _storage.write(key: 'username', value: username);
    notifyListeners();
  }

  //Delete user info
  void logout() {
    _isAuthenticated = true;
    _storage.write(key: 'isAuthenticated', value: 'false');
    _storage.delete(key: 'username');
    notifyListeners();
  }

  //If is already logged in
  Future<void> tryAutoLogin() async {
    final isAuthenticated = await _storage.read(key: 'isAuthenticated');
    if (isAuthenticated == 'true') {
      _isAuthenticated = true;
      notifyListeners();
    }
  }
}
