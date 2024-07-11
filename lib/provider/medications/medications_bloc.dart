import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medications/medications_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'medications_event.dart';
part 'medications_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final MedicationRepository medicationRepository;

  MedicationBloc(this.medicationRepository) : super(MedicationLoading()) {
    on<LoadMedications>(_onLoadMedications);
    on<AddMedication>(_onAddMedication);
    on<UpdateMedication>(_onUpdateMedication);
    on<DeleteMedication>(_onDeleteMedication);
    on<MedicationsUpdated>(_onMedicationsUpdated);
  }

  Future<void> _onLoadMedications(
      LoadMedications event, Emitter<MedicationState> emit) async {
    print("===================ON LOAD MEDICATIONS==================");
    print(event.userId);
    medicationRepository.getMedications(event.userId).listen((medications) {
      print("Medications loaded: ${medications.length}");
      add(MedicationsUpdated(medications));
    });
  }

  Future<void> _onAddMedication(
      AddMedication event, Emitter<MedicationState> emit) async {
    await medicationRepository.addMedication(event.medication);
  }

  Future<void> _onUpdateMedication(
      UpdateMedication event, Emitter<MedicationState> emit) async {
    await medicationRepository.updateMedication(event.medication);
  }

  Future<void> _onDeleteMedication(
      DeleteMedication event, Emitter<MedicationState> emit) async {
    await medicationRepository.deleteMedication(event.medicationId);
  }

  void _onMedicationsUpdated(
      MedicationsUpdated event, Emitter<MedicationState> emit) {
    emit(MedicationLoaded(event.medications));
  }
}
