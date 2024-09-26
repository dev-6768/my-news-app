import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<Map<String, String>> {
  AuthNotifier() : super({'email': '', 'password': ''});

  Future<void> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('emailKey') ?? '';
    String? password = prefs.getString('passwordKey') ?? '';

    state = {'email': email, 'password': password}; // Update the state
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, Map<String, String>>((ref) {
  return AuthNotifier();
});