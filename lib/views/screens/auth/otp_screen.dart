import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                'assets/images/otp.png',
                width: size.width * 0.55,
              ),
              const SizedBox(
                height: 20,
              ),
              loginTextFeild('Enter OTP', false),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}