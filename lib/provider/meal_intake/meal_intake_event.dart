part of 'meal_intake_bloc.dart';

abstract class MealIntakeEvent extends Equatable {
  const MealIntakeEvent();

  @override
  List<Object> get props => [];
}

class LoadMealIntakes extends MealIntakeEvent {
  final String userId;

  const LoadMealIntakes(this.userId);

  @override
  List<Object> get props => [userId];
}

class LoadMealIntakeById extends MealIntakeEvent {
  final String mealIntakeId;
  final DateTime date;

  const LoadMealIntakeById(this.mealIntakeId, this.date);

  @override
  List<Object> get props => [mealIntakeId, date];
}

class LoadMealIntakeByDate extends MealIntakeEvent {
  final String mealIntakeId;
  final DateTime date;

  const LoadMealIntakeByDate(this.mealIntakeId, this.date);

  @override
  List<Object> get props => [mealIntakeId, date];
}

class AddMealIntake extends MealIntakeEvent {
  final MealIntake mealIntake;

  const AddMealIntake(this.mealIntake);

  @override
  List<Object> get props => [mealIntake];
}

class UpdateMealIntake extends MealIntakeEvent {
  final MealIntake mealIntake;
  final String mealIntakeId;

  const UpdateMealIntake(this.mealIntake, this.mealIntakeId);

  @override
  List<Object> get props => [mealIntake, mealIntakeId];
}

class DeleteMealIntake extends MealIntakeEvent {
  final String mealIntakeId;

  const DeleteMealIntake(this.mealIntakeId);

  @override
  List<Object> get props => [mealIntakeId];
}

class MealIntakesUpdated extends MealIntakeEvent {
  final List<MealIntake> mealIntakes;

  const MealIntakesUpdated(this.mealIntakes);

  @override
  List<Object> get props => [mealIntakes];
}
