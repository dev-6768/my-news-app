import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static Future<User?> handleSignInEmail(BuildContext context, String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final result = await auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;

      if(context.mounted) {
        if(user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("emailKey", email);
          prefs.setString("passwordKey", password);

          if(context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                'User Log in Successful!',
                style: GoogleFonts.poppins(
                  color: AppColors.kWhite,
                ),
              )),
            );
          }
          return user;
        }

        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              'User Log in Failed!',
              style: GoogleFonts.poppins(
                color: AppColors.kWhite,
              ),
            )),
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
          SnackBar(content: Text(
            'User Log in Failed!',
            style: GoogleFonts.poppins(
              color: AppColors.kWhite,
            ),
          )),
        );
        return null;
      }

      else {
        return null;
      }
    }
  }
}