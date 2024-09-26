import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginFormEmailTextFieldWidget extends StatelessWidget {
  final String initialValue;
  const LoginFormEmailTextFieldWidget({super.key, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'email',
      initialValue: initialValue,
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
    );
  }
}

class LoginFormPasswordTextFieldWidget extends StatelessWidget {
  final String initialValue;
  const LoginFormPasswordTextFieldWidget({super.key, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      initialValue: initialValue,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: FormBuilderValidators.required(),
    );
  }
}