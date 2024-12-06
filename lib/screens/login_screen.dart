import 'package:diabuddy/api/auth_api.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/onboarding.dart';
import 'package:diabuddy/widgets/bottomnavbar.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/iconbutton.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/textlink.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    void handleEmailChange(String value) {
      email = value;
    }

    void handlePasswordChange(String value) {
      password = value;
    }

    void handleLoginButtonClicked() {}

    Future<void> handleGoogleSignIn({required BuildContext context}) async {
      try {
        final user = await context.read<UserAuthProvider>().authService.signInWithGoogle();
        if (context.mounted && user != null) {
          User? signedInUser = context.read<UserAuthProvider>().user;

          bool isNew = await context.read<UserAuthProvider>().addUser(signedInUser!.uid);
          if (context.mounted && isNew == true) {
            if (!context.mounted) return;
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: const Text('User not registered!'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (context.mounted && isNew == false) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const BottomNavBar();
            }));
          }
        }
      } on NoGoogleAccountChosenException {
        return;
      } on FirebaseException catch (e) {
        if (!context.mounted) return;
        errorMessage = e.message!;
      }
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
                        child: Image.asset('./assets/images/logo.png', fit: BoxFit.cover),
                      )),
                ),
                const SizedBox(height: 10),
                const TextWidget(text: "Login", style: 'bodyLarge'),
                const SizedBox(
                  height: 15,
                ),
                const TextWidget(text: "Welcome back! Log in to your account.", style: 'bodySmall'),
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
                                height: 8,
                              ),
                              Row(children: [
                                TextButton(
                                    onPressed: handleLoginButtonClicked,
                                    child: Text("Forgot Password",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ))),
                              ]),
                              ButtonWidget(
                                style: 'filled',
                                label: "Login",
                                callback: () {},
                              ),
                              Divider(
                                color: Colors.grey[400],
                                height: 0.5,
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20),
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
                                    callback: () => handleGoogleSignIn(context: context),
                                    icon: './assets/images/google logo.png'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                      child: const TextWidget(
                                        text: 'Not a member?',
                                        style: 'bodySmall',
                                      )),
                                  TextLink(
                                      label: "Signup",
                                      callback: () {
                                        Navigator.pushNamed(context, '/signupScreen');
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
