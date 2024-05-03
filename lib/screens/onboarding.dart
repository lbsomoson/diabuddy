import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import 'package:wheel_slider/wheel_slider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // weight
  late WeightSliderController _controller;
  double _weight = 30.0;

  // height in meters:
  final int _totalCount = 100;
  final int _initValue = 50;
  int _currentValue = 50;

  final int _nTotalCount = 50;
  final int _nInitValue = 10;
  int _nCurrentValue = 10;

  final int _cInitValue = 7;
  int _cCurrentValue = 7;

  @override
  Widget build(BuildContext context) {
    Widget page1() {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const TextWidget(text: "How old are you?", style: "bodyLarge"),
          const SizedBox(
            height: 5,
          ),
          WheelSlider.number(
            horizontal: false,
            verticalListHeight: 500.0,
            // listHeight: 800,
            itemSize: 45,
            perspective: 0.01,
            totalCount: _nTotalCount,
            initValue: _nInitValue,
            unSelectedNumberStyle: TextStyle(
              fontSize: 25.0,
              color: Colors.grey[500],
            ),
            selectedNumberStyle: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            currentIndex: _nCurrentValue,
            onValueChanged: (val) {
              setState(() {
                _nCurrentValue = val;
              });
            },
            hapticFeedbackType: HapticFeedbackType.heavyImpact,
          ),
        ],
      );
    }

    Widget page2() {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const TextWidget(text: "What is your gender?", style: "bodyLarge"),
          const SizedBox(
            height: 5,
          ),
          const TextWidget(
              text: "This will help us calculate your calories.",
              style: 'bodySmall'),
          const SizedBox(
            height: 35,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                splashColor: Theme.of(context).colorScheme.secondary,
                onTap: () {},
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.male,
                      color: Color.fromRGBO(100, 204, 197, 1),
                      size: 100,
                    ), // icon
                    Text("Male",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(100, 204, 197, 1),
                        )), // text
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                splashColor: Theme.of(context).colorScheme.secondary,
                onTap: () {},
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.female,
                      color: Color.fromRGBO(100, 204, 197, 1),
                      size: 100,
                    ), // icon
                    Text("Female",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(100, 204, 197, 1),
                        )), // text
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget page3() {
      _controller = WeightSliderController(
          initialWeight: _weight, minWeight: 0, interval: 0.1);
      // @override
      // void initState() {
      //   super.initState();
      // }

      @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

      return Column(children: [
        const SizedBox(
          height: 50,
        ),
        const TextWidget(
            text: "What is your weight in kilograms?", style: "bodyLarge"),
        const SizedBox(
          height: 5,
        ),
        const TextWidget(
            text: "This will help us calculate your body mass index.",
            style: 'bodySmall'),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200.0,
          alignment: Alignment.center,
          child: Text(
            "${_weight.toStringAsFixed(1)} kg",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        VerticalWeightSlider(
          isVertical: false,
          controller: _controller,
          decoration: const PointerDecoration(
            width: 130.0,
            height: 3.0,
            largeColor: Color(0xFF898989),
            mediumColor: Color(0xFFC5C5C5),
            smallColor: Color(0xFFF0F0F0),
            gap: 30.0,
          ),
          onChanged: (double value) {
            setState(() {
              _weight = value;
            });
          },
          indicator: Container(
            height: 3.0,
            width: 200.0,
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ]);
    }

    Widget page4() {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const TextWidget(
              text: "What is your height in meters?", style: "bodyLarge"),
          const SizedBox(
            height: 5,
          ),
          const TextWidget(
              text: "This will help us calculate your body mass index.",
              style: 'bodySmall'),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text(
              "${_weight.toStringAsFixed(1)} m",
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          VerticalWeightSlider(
            controller: _controller,
            decoration: const PointerDecoration(
              width: 130.0,
              height: 3.0,
              largeColor: Color(0xFF898989),
              mediumColor: Color(0xFFC5C5C5),
              smallColor: Color(0xFFF0F0F0),
              gap: 30.0,
            ),
            onChanged: (double value) {
              setState(() {
                _weight = value;
              });
            },
            indicator: Container(
              height: 3.0,
              width: 200.0,
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          home: OnBoardingSlider(
            controllerColor: Theme.of(context).colorScheme.primary,
            headerBackgroundColor: Colors.white,
            pageBackgroundColor: Colors.white,
            finishButtonText: 'Finish',
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            skipTextButton: const Text('Skip'),
            trailing: const Text('Done'),
            trailingFunction: () {
              Navigator.pushNamed(context, '/dashboardScreen');
            },
            background: [
              Container(),
              Container(),
              Container(),
              Container(),
            ],
            totalPage: 4,
            speed: 1.5,
            pageBodies: [
              page1(),
              page2(),
              page3(),
              page4(),
            ],
          ),
        )));
  }
}
