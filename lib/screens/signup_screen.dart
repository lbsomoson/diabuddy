import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/iconbutton.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/textlink.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 350,
      height: 50,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: null,
        ),
      ),
    );
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    void handleEmailChange(String value) {
      email = value;
    }

    void handlePasswordChange(String value) {
      password = value;
    }

    void handleConfirmPasswordChange(String value) {
      confirmPassword = value;
    }

    void handleSignupButtonClicked() {}

    void handleGoogleSignUp() {
      // Navigator.pushNamed(context, '/onboarding');
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Image.asset('./assets/images/logo-with-name.png',
                            fit: BoxFit.cover),
                      )),
                ),
                const TextWidget(text: "Sign Up", style: 'bodyLarge'),
                const SizedBox(
                  height: 15,
                ),
                const TextWidget(
                    text:
                        "Get started in a few clicks to create your account and explore all the features.",
                    style: 'bodySmall'),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                label: "Email",
                                hintText: "Enter your email",
                                type: "String",
                                callback: handleEmailChange,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                label: "Password",
                                hintText: "Enter your password",
                                type: "Password",
                                callback: handlePasswordChange,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                label: "Confirm Password",
                                hintText: "Confirm your password",
                                type: "Password",
                                callback: handleConfirmPasswordChange,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ButtonWidget(
                                  style: 'filled',
                                  label: "Sign Up",
                                  callback: () {
                                    handleSignupButtonClicked();
                                  }),
                              Divider(
                                color: Colors.grey[400],
                                height: 0.5,
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: const TextWidget(
                                    text: 'Or continue with',
                                    style: 'bodySmall',
                                  )),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: IconButtonWidget(
                                    label: 'Google',
                                    callback: handleGoogleSignUp,
                                    icon: './assets/images/google logo.png'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      child: const TextWidget(
                                        text: 'Already have an account?',
                                        style: 'bodySmall',
                                      )),
                                  TextLink(
                                      label: "Sign In",
                                      callback: () {
                                        Navigator.pushNamed(
                                            context, '/loginScreen');
                                      })
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
