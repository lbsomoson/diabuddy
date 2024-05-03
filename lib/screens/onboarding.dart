import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Widget page1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(text: "What is your gender?", style: "bodyLarge"),
          const SizedBox(
            height: 15,
          ),
          const TextWidget(
              text: "This will help us calculate your calories.",
              style: 'bodySmall'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, // Set the border color to primary color
                    width: 2.0, // Set the border width
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderOnForeground: true,
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    splashColor:
                        Theme.of(context).colorScheme.secondary, // splash color
                    onTap: () {}, // button pressed
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.male_outlined,
                          color: Colors.white,
                          size: 100,
                        ), // icon
                        Text("Male",
                            style: TextStyle(color: Colors.white)), // text
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          home: OnBoardingSlider(
            headerBackgroundColor: Colors.white,
            // pageBackgroundColor: Colors.white,
            pageBackgroundColor: Colors.grey[100],
            finishButtonText: 'Finish',
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            skipTextButton: const Text('Skip'),
            trailing: const Text('Home'),
            trailingFunction: () {
              Navigator.pushNamed(context, '/dashboardScreen');
            },
            background: [
              Container(),
              Container(),
            ],
            totalPage: 2,
            speed: 1.8,
            pageBodies: [
              page1(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Column(
                  children: <Widget>[
                    SizedBox(
                      height: 480,
                    ),
                    Text('Description Text 2'),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
