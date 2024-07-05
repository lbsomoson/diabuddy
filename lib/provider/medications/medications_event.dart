part of 'medications_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();

  @override
  List<Object> get props => [];
}

class LoadMedications extends MedicationEvent {
  final String userId;

  const LoadMedications(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddMedication extends MedicationEvent {
  final MedicationIntake medication;

  const AddMedication(this.medication);

  @override
  List<Object> get props => [medication];
}

class UpdateMedication extends MedicationEvent {
  final MedicationIntake medication;

  const UpdateMedication(this.medication);

  @override
  List<Object> get props => [medication];
}

class DeleteMedication extends MedicationEvent {
  final String medicationId;

  const DeleteMedication(this.medicationId);

  @override
  List<Object> get props => [medicationId];
}

class MedicationsUpdated extends MedicationEvent {
  final List<MedicationIntake> medications;

  const MedicationsUpdated(this.medications);

  @override
  List<Object> get props => [medications];
}
