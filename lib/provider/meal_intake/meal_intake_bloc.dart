import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/provider/meal_intake/meal_intake_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'meal_intake_event.dart';
part 'meal_intake_state.dart';

class MealIntakeBloc extends Bloc<MealIntakeEvent, MealIntakeState> {
  final MealIntakeRepository mealIntakeRepository;

  MealIntakeBloc(this.mealIntakeRepository) : super(MealIntakeLoading()) {
    on<LoadMealIntakes>(_onLoadMealIntakes);
    on<LoadMealIntakeById>(_onLoadMealIntakeById);
    on<LoadMealIntakeByDate>(_onLoadMealIntakeByDate);
    on<AddMealIntake>(_onAddMealIntake);
    on<UpdateMealIntake>(_onUpdateMealIntake);
    on<DeleteMealIntake>(_onDeleteMealIntake);
    on<MealIntakesUpdated>(_onMealIntakesUpdated);
  }

  Future<void> _onLoadMealIntakes(LoadMealIntakes event, Emitter<MealIntakeState> emit) async {
    mealIntakeRepository.getMealIntakes(event.userId).listen((mealIntakes) {
      add(MealIntakesUpdated(mealIntakes));
    });
  }

  // get one meal inake by id
  Future<void> _onLoadMealIntakeById(LoadMealIntakeById event, Emitter<MealIntakeState> emit) async {
    try {
      emit(MealIntakeLoading());
      final mealIntake = await mealIntakeRepository.getMealIntakeById(event.mealIntakeId);
      emit(SingleMealIntakeLoaded(mealIntake));
    } catch (e) {
      emit(MealIntakeError(e.toString()));
    }
  }

  // get meal inakes by date
  // Future<void> _onLoadMealIntakeByDate(LoadMealIntakeByDate event, Emitter<MealIntakeState> emit) async {
  //   mealIntakeRepository.getMealIntakesByDate(event.mealIntakeId, event.date).listen((mealIntakes) {
  //     emit(MealIntakeByDateLoaded(mealIntakes));
  //   });
  // }

  // Future<void> _onLoadMealIntakeByDate(LoadMealIntakeByDate event, Emitter<MealIntakeState> emit) async {
  //   try {
  //     emit(MealIntakeLoading());

  //     await emit.forEach(
  //       mealIntakeRepository.getMealIntakesByDate(event.mealIntakeId, event.date),
  //       onData: (List<Map<String, dynamic>> mealIntakes) {
  //         return MealIntakeByDateLoaded(mealIntakes);
  //       },
  //       onError: (error, stackTrace) {
  //         return MealIntakeError(error.toString());
  //       },
  //     );
  //   } catch (error) {
  //     emit(MealIntakeError(error.toString()));
  //   }
  // }

  Future<void> _onLoadMealIntakeByDate(LoadMealIntakeByDate event, Emitter<MealIntakeState> emit) async {
    try {
      emit(MealIntakeLoading());

      await emit.forEach(
        mealIntakeRepository.getMealIntakesByDate(event.mealIntakeId, event.date),
        onData: (List<Map<String, dynamic>> mealIntakeMaps) {
          // final mealIntakes = mealIntakeMaps.map((data) => MealIntake.fromJson(data, event.mealIntakeId)).toList();
          return MealIntakeByDateLoaded(mealIntakeMaps);
        },
        onError: (error, stackTrace) {
          return MealIntakeError(error.toString());
        },
      );
    } catch (error) {
      emit(MealIntakeError(error.toString()));
    }
  }

  Future<void> _onAddMealIntake(AddMealIntake event, Emitter<MealIntakeState> emit) async {
    await mealIntakeRepository.addMealIntake(event.mealIntake);
  }

  Future<void> _onUpdateMealIntake(UpdateMealIntake event, Emitter<MealIntakeState> emit) async {
    await mealIntakeRepository.updateMealIntake(event.mealIntake, event.mealIntakeId);
  }

  Future<void> _onDeleteMealIntake(DeleteMealIntake event, Emitter<MealIntakeState> emit) async {
    await mealIntakeRepository.deleteMealIntake(event.mealIntakeId);
  }

  void _onMealIntakesUpdated(MealIntakesUpdated event, Emitter<MealIntakeState> emit) {
    emit(MealIntakeLoaded(event.mealIntakes));
  }
}
