import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/controller/text_field/text_field_validator_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/views/widget/login_textfield.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/controller/text_field/text_field_controller.dart';

import 'package:flutter_app/services/auth/firebase_auth_methods.dart';

bool hiddentextField = false;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _otpTextController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

// @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formkey,
              child: Consumer<TextfieldValidatorProvider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Create a new account',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      loginTextField('Email Address', false,
                          _emailTextController, context, const Text('Send OTP'),
                          validator: provider.validateEmail),
                      const SizedBox(
                        height: 20,
                      ),
                      loginTextField('otp', false, _otpTextController, context,
                          const Text('Verify OTP'),
                          email: _emailTextController.text,
                          validator: provider.validateOTP),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<ShowTextFeildProvider>(
                        builder: (context, showTextFeildProvider, _) {
                          return Visibility(
                            visible: showTextFeildProvider.isVisible,
                            child: loginTextField(
                                'Password',
                                true,
                                _passwordTextController,
                                //  context.read<TextfieldValidatorProvider>().validatePassword(_passwordTextController.text) as String? Function(String? value),
                                context,
                                const Icon(
                                  Icons.clear,
                                  size: 16,
                                ),
                                validator: provider.validatePassword),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (FormBuilder.of(context)!.validate()) {
                              // signupUser();
                              context
                                  .read<FirebaseAuthMethods>()
                                  .signUpWithEmail(
                                      email: _emailTextController.text.trim(),
                                      password:
                                          _passwordTextController.text.trim(),
                                      context: context);
                              context
                                  .read<ShowTextFeildProvider>()
                                  .toggleVisbility(false);
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      )),
    );
  }
}
