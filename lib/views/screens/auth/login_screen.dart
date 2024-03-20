import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/controller/text_field_validator_controller.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/signup_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: FormBuilder(
              // autovalidateMode: AutovalidateMode.values.last,
              key: _formkey,
              child: Consumer<TextfieldValidatorProvider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        width: size.width * .4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      loginTextField(
                          "Email",
                          false,
                          _emailTextController,
                          // context.read<TextfieldValidatorProvider>().validateEmail(_emailTextController.text) as String? Function(String? value),
                          context,
                          const Icon(
                            Icons.clear,
                            size: 16,
                          ),
                          validator: provider.validateEmail),
                      const SizedBox(
                        height: 20,
                      ),
                      loginTextField(
                          "Password",
                          true,
                          _passwordTextController,
                          //  context.read<TextfieldValidatorProvider>().validatePassword(_passwordTextController.text) as String? Function(String? value),
                          context,
                          const Icon(
                            Icons.clear,
                            size: 16,
                          ),
                          validator: provider.validatePassword),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(color: kGreyColor),
                              ))
                        ],
                      ),
                      // const SizedBox(height: 15,),
                      ElevatedButton(
                          onPressed: () {
                            if (FormBuilder.of(context)!.validate()) {
                              // loginUser();
                              context
                                  .read<FirebaseAuthMethods>()
                                  .loginWithEmail(
                                      email: _emailTextController.text.trim(),
                                      password:
                                          _passwordTextController.text.trim(),
                                      context: context);
                            }
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => BottomNavBar(),
                            //     ),
                            //     (route) => false);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * .38,
                            height: 1,
                            decoration: const BoxDecoration(color: kGreyColor),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Or',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: size.width * .38,
                            height: 1,
                            decoration: const BoxDecoration(color: kGreyColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<FirebaseAuthMethods>()
                                  .googleLogin(context);
                            },
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/images/google.png'),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                'assets/images/facebook.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      )
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
