import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  TextEditingController _otpTextController = TextEditingController();

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
                'assets/images/otp.png',
                width: size.width * 0.55,
              ),
              const SizedBox(
                height: 20,
              ),
              // loginTextFeild('Enter OTP', false, _otpTextController,),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>  LoginScreen(),
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
