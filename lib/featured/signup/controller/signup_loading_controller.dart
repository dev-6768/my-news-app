import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/featured/login/view/login_page.dart';
import 'package:my_news_app/featured/signup/controller/signup_controller.dart';
import 'package:my_news_app/shared/api_client/dio_client_provider.dart';

class SignupLoadingNotifier extends StateNotifier<bool> {
  SignupLoadingNotifier() : super(false); // Initial state is not loading

  // Method to simulate an async operation
  Future<void> loadData(GlobalKey<FormBuilderState> formKey, BuildContext context) async {
    state = true;  // Start loading
    if (formKey.currentState?.saveAndValidate() ?? false) {
      if(context.mounted) {
        var formData = formKey.currentState?.value;

        await SignupController.handleSignUp(
          context, 
          formData!['name'], 
          formData['email'],
          formData['password'], 
        );

        if(context.mounted) { 
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const LoginPage())
          );
        }
      }
      
    } 
    
    else {
      talker.debug("Validation failed");
    }

    state = false; // Stop loading
  }
}

// Step 2: Create a StateNotifierProvider for the LoadingNotifier
final signupLoadingProvider = StateNotifierProvider<SignupLoadingNotifier, bool>((ref) {
  return SignupLoadingNotifier();
});