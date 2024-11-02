part of 'meal_bloc.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class GetMeal extends MealEvent {
  final String mealId;

  const GetMeal(this.mealId);

  @override
  List<Object> get props => [mealId];
}

class LoadMeals extends MealEvent {
  final String userId;

  const LoadMeals(this.userId);

  @override
  List<Object> get props => [userId];
}

class MealsUpdated extends MealEvent {
  final List<Meal> meals;

  const MealsUpdated(this.meals);

  @override
  List<Object> get props => [meals];
}
