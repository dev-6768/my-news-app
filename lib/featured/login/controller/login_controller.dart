import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Future<User?> handleSignInEmail(BuildContext context, String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;

      if(context.mounted) {
        if(user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Log in Successful!')),
          );
          return user;
        }

        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Log in Failed!')),
          );
          return null;
        }
      }

      else {
        return null;
      }
    }

    catch(exception) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Log in Failed!')),
        );
        return null;
      }

      else {
        return null;
      }
    }
  }
}