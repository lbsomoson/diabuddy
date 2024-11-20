import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'package:diabuddy/models/user_model.dart';

class OnboardingScreen extends StatefulWidget {
  final String id;
  const OnboardingScreen({required this.id, super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // weight
  late WeightSliderController _weightController, _heightController;
  double _weight = 50.0;
  double _height = 1.7;

  final int _nTotalCount = 110;
  final int _nInitValue = 50;
  int _nCurrentValue = 10;

  String? _selectedGender;

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
          SizedBox(
            width: 100,
            child: WheelSlider.number(
              horizontal: false,
              verticalListHeight: 500.0,
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
          const TextWidget(text: "This will help us calculate your calories.", style: 'bodySmall'),
          const SizedBox(
            height: 35,
          ),
          GenderSelectionContainer(
            gender: "Male",
            selectedGender: _selectedGender,
            onTap: () {
              setState(() {
                _selectedGender = "Male";
              });
            },
          ),
          GenderSelectionContainer(
            gender: "Female",
            selectedGender: _selectedGender,
            onTap: () {
              setState(() {
                _selectedGender = "Female";
              });
            },
          ),
        ],
      );
    }

    Widget page3() {
      _weightController =
          WeightSliderController(initialWeight: _weight, minWeight: 0, interval: 0.1);

      @override
      void dispose() {
        _weightController.dispose();
        super.dispose();
      }

      return Column(children: [
        const SizedBox(
          height: 50,
        ),
        const TextWidget(text: "What is your weight in kilograms?", style: "bodyLarge"),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "This will help us calculate your body mass index.",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
          controller: _weightController,
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
      _heightController =
          WeightSliderController(initialWeight: _height, minWeight: 0, interval: 0.1);
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const TextWidget(text: "What is your height in meters?", style: "bodyLarge"),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "This will help us calculate your body mass index.",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200.0,
            alignment: Alignment.center,
            child: Text(
              "${_height.toStringAsFixed(1)} m",
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          VerticalWeightSlider(
            controller: _heightController,
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
                _height = value;
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
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
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
            onFinish: () async {
              AppUser appuser = AppUser(
                age: _nCurrentValue,
                gender: _selectedGender,
                weight: _weight,
                height: _height,
              );
              await context.read<UserAuthProvider>().onboarding(widget.id, appuser);

              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              }
            },
          ),
        )));
  }
}

class GenderSelectionContainer extends StatelessWidget {
  final String gender;
  final String? selectedGender;
  final VoidCallback onTap;

  const GenderSelectionContainer({
    Key? key,
    required this.gender,
    required this.selectedGender,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = gender == selectedGender;
    final Color selectedColor = Theme.of(context).colorScheme.primary;
    const Color unselectedColor = Color.fromRGBO(100, 204, 197, 1);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isSelected ? selectedColor : unselectedColor,
          width: 2.0,
        ),
        color: isSelected ? selectedColor : Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          splashColor: Theme.of(context).colorScheme.secondary,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Icon(
                gender == "Male" ? Icons.male : Icons.female,
                color: isSelected ? Colors.white : unselectedColor,
                size: 100,
              ),
              Text(gender,
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.white : unselectedColor,
                  )),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
