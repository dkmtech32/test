import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


// import 'package:flutter_app/views/screens/auth/otp_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
// import 'package:flutter_app/views/screens/auth/login_screen.dart';
import 'package:flutter_app/core/color.dart';

import 'package:flutter_app/services/auth/firebase_auth_methods.dart';

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
                // loginTextField(
                //     'otp',
                //     false,
                //     _otpTextController,
                //     validateOTP,
                //     context,
                //     const Text('Verify OTP'),
                //     _emailTextController.text),
                // const SizedBox(
                //   height: 20,
                // ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 3),
                            blurStyle: BlurStyle.inner),
                      ],
                    ),
                    child: TextFormField(
                      controller: _otpTextController,
                      decoration: InputDecoration(
                          fillColor: Theme.of(context).primaryColor,
                          filled: true,
                          suffix: InkWell(
                              onTap: () {
                                hiddentextField = verifyOTP(
                                    _emailTextController.text.trim(),
                                    _otpTextController.text,
                                    context);
                                if (hiddentextField) {
                                  setState(() {
                                    hiddentextField = true;
                                  });
                                }
                              },
                              child: Text('Verify OTP')),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: kCyanColor)),
                          labelText: 'Otp'),
                      obscureText: false,
                      validator: validateOTP,
                    ),
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
