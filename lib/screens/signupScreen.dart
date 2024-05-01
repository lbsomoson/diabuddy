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

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    String confirmPassword = '';

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
                                    label: 'Sign up with Google',
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

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.all(15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: SizedBox(
//                     height: 80,
//                     width: 80,
//                     child: Center(
//                       child: Image.asset('assets/images/logo-with-name.png',
//                           fit: BoxFit.cover),
//                     )),
//               ),
//               SizedBox(height: 10),
//               const Text(
//                 "Sign Up",
//                 // toLang: 'fi',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromRGBO(23, 107, 135, 1),
//                     fontSize: 20),
//               ),
//               const Text(
//                 "Get started in a few clicks to create your account and explore all the features.",
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//               SizedBox(height: 40),
//               Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       // CustomTextField(
//                       //     label: "Name", hintText: "Enter your name"),
//                       // CustomTextField(
//                       //     label: "Password", hintText: "Enter your password"),
//                       // CustomTextField(
//                       //     label: "Confirm Password",
//                       //     hintText: "Re-enter your password"),
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 30),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           // color: Colors.grey.shade200,
//                           color: Color.fromRGBO(100, 204, 197, 1),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: TextButton(
//                           onPressed: () {},
//                           child: Text("Signup",
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       Divider(
//                         color: Colors.black,
//                         height: 0.5,
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 20),
//                         child: Text(
//                           "Or continue with",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                       Container(
//                         // margin: EdgeInsets.symmetric(vertical: 5),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           border: Border.all(
//                             color: Color.fromRGBO(100, 204, 197, 1),
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: TextButton.icon(
//                           style: TextButton.styleFrom(
//                             foregroundColor: Color.fromRGBO(100, 204, 197, 1),
//                             // textStyle: const TextStyle(fontSize: 20)),
//                           ),
//                           icon: const Icon(Icons.add),
//                           onPressed: () {},
//                           label: const Text('Google'),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         // crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.symmetric(
//                                 vertical: 20, horizontal: 0),
//                             child: Text(
//                               "Already have an account?",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                           TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                     decoration: TextDecoration.underline,
//                                     color: Color.fromRGBO(100, 204, 197, 1)),
//                               )),
//                           // InkWell(onTap: launchUrl(Uri.parse('https://www.google.com')), child: Text("Login"))
//                         ],
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
