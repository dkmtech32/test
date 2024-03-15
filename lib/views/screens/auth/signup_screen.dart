import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/otp_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              Image.asset(
                'assets/images/signup.png',
                width: size.width * .5,
              ),
              const SizedBox(
                height: 10,
              ),
              loginTextFeild('Username', false),
              const SizedBox(
                height: 20,
              ),
              loginTextFeild('Full Name', false),
              const SizedBox(
                height: 20,
              ),
              loginTextFeild('Email Address', false),
              const SizedBox(
                height: 20,
              ),
              loginTextFeild('Password', true),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const OTPScreen(),
                    ));
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