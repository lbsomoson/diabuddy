import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/meal/meal_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFoodManually extends StatefulWidget {
  const AddFoodManually({super.key});

  @override
  State<AddFoodManually> createState() => _AddFoodManuallyState();
}

class _AddFoodManuallyState extends State<AddFoodManually> {
  final _formKey = GlobalKey<FormState>();

  String mealName = "";
  List<Meal> meals = [];

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
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 80),
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
                      BlocListener<MealBloc, MealState>(
                        listener: (context, state) {
                          if (state is SingleMealLoaded) {
                            final meal = state.meal;

                            setState(() {
                              // add the meal or perform any action with it
                              meals.add(meal);
                            });
                          } else if (state is MealNotFound) {
                            // show an error message if the medication was not found
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
                          } else if (state is MealError) {
                            // handle any errors here
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.message),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: ButtonWidget(
                          style: 'filled',
                          label: "Add Food",
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<MealBloc>().add(GetMeal(mealName));
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      meals.isEmpty
                          ? const SizedBox()
                          : Divider(color: Colors.grey[400]),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          meals[index].mealName!,
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
            meals.isEmpty
                ? const SizedBox()
                : Positioned(
                    bottom: 25,
                    left: 25,
                    right: 25,
                    child: ButtonWidget(
                        style: 'filled',
                        label: "Submit",
                        callback: () {
                          for (Meal m in meals) {
                            print('${m.mealId}: ${m.mealName}');
                          }
                        }),
                  ),
          ],
        )));
  }
}
