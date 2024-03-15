import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/auth/otp_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';
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
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void signupUser() async {
    await FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(
      email: _emailTextController.text,
      password: _passwordTextController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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

                  // Image.asset(
                  //   'assets/images/signup.png',
                  //   width: size.width * .4,
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  // loginTextFeild('Username', false, _userNameTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // loginTextFeild('Full Name', false, _fullNameTextController),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  loginTextFeild('Email Address', false, _emailTextController,validateEmail),
                  const SizedBox(
                    height: 20,
                  ),
                  loginTextFeild('Password', true, _passwordTextController,validatePassword),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          signupUser();
                        }
                      //  if(_emailTextController.text.isEmpty){
                      //   showSnackbar(context, 'Please enter email');
                      //  }else if(_passwordTextController.text.isEmpty){
                      //   showSnackbar(context, 'Please enter your password');
                      //  }else{
                      //   // signupUser();

                      //  }


                        // signupUser();
                        // FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: _emailTextController.text.trim(),
                        //         password: _passwordTextController.text.trim())
                        //     .then((value) {
                        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => HomeScreen(),
                        //   )).onError((error, stackTrace) {
                        //     print(error.toString());
                        //   });
                        // });
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
