part of 'meal_intake_bloc.dart';

abstract class MealIntakeState extends Equatable {
  const MealIntakeState();

  @override
  List<Object> get props => [];
}

class MealIntakeLoading extends MealIntakeState {}

class SingleMealIntakeLoaded extends MealIntakeState {
  final MealIntake mealIntake;

  const SingleMealIntakeLoaded(this.mealIntake);

  @override
  List<Object> get props => [mealIntake];
}

class MealIntakeByDateLoaded extends MealIntakeState {
  final List<MealIntake> mealIntakes;

  const MealIntakeByDateLoaded(this.mealIntakes);

  @override
  List<Object> get props => [mealIntakes];
}

class MealIntakeLoaded extends MealIntakeState {
  final List<MealIntake> mealIntake;

  const MealIntakeLoaded(this.mealIntake);

  @override
  List<Object> get props => [mealIntake];
}

class MealIntakeError extends MealIntakeState {
  final String message;

  const MealIntakeError(this.message);

  @override
  List<Object> get props => [message];
}
