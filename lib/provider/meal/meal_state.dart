part of 'meal_bloc.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

// class SingleMealLoaded extends MealState {
//   final Meal meal;

//   const SingleMealLoaded(this.meal);
// }

class MealNotFound extends MealState {}

class MealLoading extends MealState {}

class SingleMealLoaded extends MealState {
  final Meal meal;

  const SingleMealLoaded(this.meal);

  @override
  List<Object> get props => [meal];
}

class MealError extends MealState {
  final String message;

  const MealError(this.message);

  @override
  List<Object> get props => [message];
}
