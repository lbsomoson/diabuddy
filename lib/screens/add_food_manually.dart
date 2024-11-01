import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/meal_provider.dart';
import 'package:diabuddy/screens/meal_details.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFoodManually extends StatefulWidget {
  const AddFoodManually({super.key});

  @override
  State<AddFoodManually> createState() => _AddFoodManuallyState();
}

class _AddFoodManuallyState extends State<AddFoodManually> {
  final _formKey = GlobalKey<FormState>();

  String mealName = "";
  List<String> meals = ["Scrambled Egg", "Coffee 3-in-1", "Rice"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Add Food Manually"),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    25, 20, 25, 80), // Bottom padding for button space
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        callback: (String val) {
                          setState(() {
                            mealName = val;
                          });
                        },
                        hintText: "Meal Name",
                        type: "String",
                      ),
                      const SizedBox(height: 10),
                      ButtonWidget(
                        style: 'filled',
                        label: "Add Food",
                        callback: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic>? mealMap = await context
                                .read<MealProvider>()
                                .getMealInfo(mealName);

                            if (mealMap != null && context.mounted) {
                              setState(() {
                                meals.add(mealName);
                              });
                            } else {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: const Text('Meal not found!'),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey[400]),
                      const SizedBox(height: 10),
                      meals.isEmpty
                          ? const SizedBox(height: 5)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: meals.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(height: 8.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        dense: true,
                                        title: Text(
                                          meals[index],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                meals.removeAt(index);
                                                setState(() {
                                                  meals = meals;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 25,
              right: 25,
              child: ButtonWidget(
                  style: 'filled', label: "Submit", callback: () {}),
            ),
          ],
        )));
  }
}
