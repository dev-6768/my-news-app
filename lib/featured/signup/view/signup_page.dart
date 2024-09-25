import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/featured/login/view/login_page.dart';
import 'package:my_news_app/featured/signup/controller/signup_loading_controller.dart';


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
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'name',
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: FormBuilderValidators.required(),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderTextField(
                            name: 'email',
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ]),
                          ),

                          const SizedBox(height: 16),
                          
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password(Greater than 6 characters.)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(6),
                            ]),
                          ),
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
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const LoginPage())
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: AppColors.appBarBackgroundColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}