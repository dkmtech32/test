import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:flutter_app/views/screens/auth/otp_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
// import 'package:flutter_app/views/screens/auth/login_screen.dart';

import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

bool hiddentextField = false;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // TextEditingController _userNameTextController = TextEditingController();

  // TextEditingController _fullNameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _otpTextController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
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
               
                loginTextField(
                  'Email Address',
                  false,
                  _emailTextController,
                  validateEmail,
                  context,
                  const Text('Send OTP'),
                ),
                const SizedBox(
                  height: 20,
                ),
                loginTextField(
                    'otp',
                    false,
                    _otpTextController,
                    validateOTP,
                    context,
                    const Text('Verify OTP'),
                    _emailTextController.text),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: hiddentextField,
                    child: loginTextField(
                      'Password',
                      true,
                      _passwordTextController,
                      validatePassword,
                      context,
                      const Icon(
                        Icons.clear,
                        size: 16,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                          // signupUser();
                          context.read<FirebaseAuthMethods>().signUpWithEmail(
                              email: _emailTextController.text.trim(),
                              password: _passwordTextController.text.trim(),
                              context: context);
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
