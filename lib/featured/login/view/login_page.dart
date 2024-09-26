import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/featured/login/controller/login_loading_controller.dart';
import 'package:my_news_app/featured/login/controller/populate_login_controller.dart';
import 'package:my_news_app/featured/login/view/widget/text_field_widget.dart';
import 'package:my_news_app/featured/signup/view/signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    ref.read(authProvider.notifier).loadCredentials();
  }
  
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingNotifier);
    final authData = ref.watch(authProvider);

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          LoginFormEmailTextFieldWidget(initialValue: authData["email"] ?? ""),
                          const SizedBox(height: 16),
                          LoginFormPasswordTextFieldWidget(initialValue: authData["password"] ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
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
                      ref.read(loginLoadingNotifier.notifier).loadData(_formKey, context);
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appBarBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here? ",
                      style: GoogleFonts.poppins(
                        color: AppColors.kBlack,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const SignUpPage())
                        );
                      },
                      child: Text(
                        'Signup',
                        style: GoogleFonts.poppins(
                          color: AppColors.appBarBackgroundColor
                        ),
                      ),
                    )
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