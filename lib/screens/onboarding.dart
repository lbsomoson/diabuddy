import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  final String id;
  const OnboardingScreen({required this.id, super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late WeightSliderController _weightController, _heightController;
  double _weight = 50.0;
  double _height = 1.7;

  final int _nTotalCount = 110;
  final int _nInitValue = 30;
  int _nCurrentValue = 10;

  String? _selectedGender;
  String? _selectedLevel;

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
          const TextWidget(text: "This will help us determine your nutritional needs.", style: 'bodySmall'),
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
          const TextWidget(text: "This will help us determine your nutritional needs.", style: 'bodySmall'),
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
      _weightController = WeightSliderController(initialWeight: _weight, minWeight: 0, interval: 0.1);

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
            style:
                TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
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
      _heightController = WeightSliderController(initialWeight: _height, minWeight: 0, interval: 0.1);
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
                  fontSize: 40.0, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
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

    Widget page5() {
      return Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const TextWidget(text: "What is your level of physical activity?", style: "bodyLarge"),
          const SizedBox(
            height: 5,
          ),
          const TextWidget(text: "This will help us calculate your ideal body weight.", style: 'bodySmall'),
          const SizedBox(
            height: 35,
          ),
          PhysicalActivityContainer(
            level: "Sedentary",
            activityIcon: FontAwesomeIcons.chair,
            short: 'Less than 5,000 steps daily',
            description: 'Mostly resting with little or no activity.',
            selectedLevel: _selectedLevel,
            onTap: () {
              setState(() {
                _selectedLevel = "Sedentary";
              });
            },
          ),
          PhysicalActivityContainer(
            level: "Light",
            activityIcon: FontAwesomeIcons.personWalking,
            short: 'About 5,000 to 7,499 steps daily',
            description:
                'Occupations that require minimal movement, mostly sitting/desk work or standing for long hours and/or with occasional walking (professional, clerical, technical workers, administrative and managerial staff, driving light vehicles (cars, jeepney). Housewives with light housework (dishwashing, preparing food).',
            selectedLevel: _selectedLevel,
            onTap: () {
              setState(() {
                _selectedLevel = "Sedentary";
              });
            },
          ),
          PhysicalActivityContainer(
            level: "Moderate",
            activityIcon: FontAwesomeIcons.personRunning,
            short: 'About 7,500 to 9,999 steps daily',
            description:
                'Occupations that require extended periods of walking, pushing or pulling or lifting or carrying heavy objects (cleaning/domestic services, waiting table, homebuilding task, farming, patient care).',
            selectedLevel: _selectedLevel,
            onTap: () {
              setState(() {
                _selectedLevel = "Moderate";
              });
            },
          ),
          PhysicalActivityContainer(
            level: "Very Active or Vigorous",
            activityIcon: FontAwesomeIcons.personSkating,
            short: 'More than 10,000 steps daily',
            description:
                'Occupations that require extensive periods of running, rapid movement, pushing or pulling heavy objects or tasks frequently requiring strenuous effort and extensive total body movements (teaching a class or skill requiring active and strenuous participation, such as aerobics or physical education instructor; firefighting; masonry and heavy construction work; coal mining; manually shoveling, using heavy non-powered tools).',
            selectedLevel: _selectedLevel,
            onTap: () {
              setState(() {
                _selectedLevel = "Very Active or Vigorous";
              });
            },
          ),
          const SizedBox(
            height: 100,
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
              Container(),
            ],
            totalPage: 5,
            speed: 1.5,
            pageBodies: [
              page1(),
              page2(),
              page3(),
              page4(),
              SingleChildScrollView(child: page5()),
            ],
            onFinish: () async {
              AppUser appuser = AppUser(
                age: _nCurrentValue,
                gender: _selectedGender,
                weight: _weight,
                height: _height,
                activityLevel: _selectedLevel,
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

class PhysicalActivityContainer extends StatelessWidget {
  final String level;
  final IconData activityIcon;
  final String description, short;
  final String? selectedLevel;
  final VoidCallback onTap;

  const PhysicalActivityContainer({
    Key? key,
    required this.level,
    required this.activityIcon,
    required this.short,
    required this.description,
    required this.selectedLevel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = level == selectedLevel;
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(
                        activityIcon,
                        color: isSelected ? Colors.white : unselectedColor,
                        size: level == 'Very Active or Vigorous' || level == 'Sedentary' ? 75 : 85,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(level,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: isSelected ? Colors.white : unselectedColor,
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(short,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isSelected ? Colors.white : unselectedColor,
                              ))),
                      Text(description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 15,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: isSelected ? Colors.white : unselectedColor,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
