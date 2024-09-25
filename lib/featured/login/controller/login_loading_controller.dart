import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/featured/home/view/home_page.dart';
import 'package:my_news_app/featured/login/controller/login_controller.dart';
import 'package:my_news_app/shared/api_client/dio_client_provider.dart';

class LoginLoadingNotifier extends StateNotifier<bool> {
  LoginLoadingNotifier() : super(false); // Initial state is not loading

  // Method to simulate an async operation
  Future<void> loadData(GlobalKey<FormBuilderState> formKey, BuildContext context) async {
    state = true;  // Start loading
    if (formKey.currentState?.saveAndValidate() ?? false) {
      var formData = formKey.currentState?.value;
      await LoginController.handleSignInEmail(
        context, 
        formData!["email"], 
        formData["password"]
      );
      
      if(context.mounted) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const HomePage())
        );
      }
      talker.debug(formKey.currentState?.value);
    } 
    
    else {
      talker.debug("Validation failed");
    }

    state = false; // Stop loading
  }
}

// Step 2: Create a StateNotifierProvider for the LoadingNotifier
final loginLoadingNotifier = StateNotifierProvider<LoginLoadingNotifier, bool>((ref) {
  return LoginLoadingNotifier();
});