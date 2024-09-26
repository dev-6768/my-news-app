import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/shared/api_client/dio_client_provider.dart';

class SignupController {
  static Future<void> addUserData(String name, String password, String email) async {
  // Reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Add a document to the 'users' collection, using the user's uid as the document ID
      await firestore.collection('users').doc().set({
        'name': name,
        'email': email,
        'createdAt': DateTime.now().toIso8601String(), // optional timestamp
      });
    } catch (e) {
      talker.debug(e);
    }
  }
  static Future<void> handleSignUp(BuildContext context, String name, String email, String password) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await addUserData(name, password, email);

      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            'User Registration Successfully!',
            style: GoogleFonts.poppins(
              color: AppColors.kWhite,
            ),
          )),
        );
      }
    }

    catch(exception) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            'User Registration Failed!',
            style: GoogleFonts.poppins(
              color: AppColors.kWhite,
            ),
          )),
        );
      }
    }
  }
}