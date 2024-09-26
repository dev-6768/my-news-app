import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/featured/login/view/login_page.dart';
import 'package:my_news_app/featured/signup/controller/signup_loading_controller.dart';
import 'package:my_news_app/featured/signup/view/widget/text_field_widget.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signupLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyNews",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarBackgroundColor,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormBuilder(
                      key: _formKey,
                      child: const Column(
                        children: [
                          FormNameTextFieldWidget(),
                          SizedBox(height: 16),
                          FormEmailTextFieldWidget(),
                          SizedBox(height: 16),
                          FormPasswordTextFieldWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
            ),

            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: isLoading
                  ? ElevatedButton(
                    onPressed: () {
                      
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBarBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    child: const CircularProgressIndicator(color: AppColors.kWhite),
                  )
                  : ElevatedButton(
                    onPressed: () async {
                      ref.watch(signupLoadingProvider.notifier).loadData(_formKey, context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBarBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    child: Text(
                      'Signup',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.poppins(
                        color: AppColors.kBlack
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const LoginPage())
                        );
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: AppColors.appBarBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}