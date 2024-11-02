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
