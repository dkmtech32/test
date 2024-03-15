import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/otp_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
import 'package:flutter_app/views/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // TextEditingController _userNameTextController = TextEditingController();

  // TextEditingController _fullNameTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

// @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _emailTextController.dispose();
//     _passwordTextController.dispose();
//   }

  void signupUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(
      email: _emailTextController.text,
      password: _passwordTextController.text,
      context: context,
    )
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => OTPScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
             
              Text(
                'Create a new account',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              
              loginTextFeild('Email Address', false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              
              loginTextFeild('Password', true, _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              
              ElevatedButton(
                  onPressed: () {
                     print(_emailTextController.text.trim());
                      signupUser();
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
