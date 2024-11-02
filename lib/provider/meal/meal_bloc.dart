import 'package:diabuddy/provider/meal/meal_repository.dart';
import 'package:diabuddy/models/meal_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository mealRepository;

  MealBloc(this.mealRepository) : super(MealLoading()) {
    on<GetMeal>(_onGetMeal);
    on<LoadMeals>(_onLoadMeals);
    on<MealsUpdated>(_onMealsUpdated);
  }

  Future<void> _onGetMeal(GetMeal event, Emitter<MealState> emit) async {
    try {
      final medication = await mealRepository.getMeal(event.mealId);
      if (medication != null) {
        emit(SingleMealLoaded(medication));
      } else {
        emit(MealNotFound());
      }
    } catch (e) {
      emit(const MealError("Failed to load meal"));
    }
  }

  Future<void> _onLoadMeals(LoadMeals event, Emitter<MealState> emit) async {
    mealRepository.getMeals().listen((meals) {
      add(MealsUpdated(meals));
    });
  }

  void _onMealsUpdated(MealsUpdated event, Emitter<MealState> emit) {
    emit(MealLoaded(event.meals));
  }
}
