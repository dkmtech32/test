import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/views/screens/auth/signup_screen.dart';
import 'package:flutter_app/views/widget/login_textfield.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/views/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void loginUser() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: _emailTextController.text,
        password: _passwordTextController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                  loginTextFeild("Email Address", false, _emailTextController,
                      validateEmail),
                  const SizedBox(
                    height: 20,
                  ),
                  loginTextFeild("Password", true, _passwordTextController,
                      validatePassword),
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
                        if (_formKey.currentState!.validate()) {
                          loginUser();
                        }
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => BottomNavBar(),
                        //     ),
                        //     (route) => false);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/google.png'),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          'assets/images/facebook.png',
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
              ),
            ),
          ),
        ),
      )),
    );
  }
}
