part of 'medications_bloc.dart';

abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

class MedicationLoading extends MedicationState {}

class MedicationLoaded extends MedicationState {
  final List<MedicationIntake> medications;

  const MedicationLoaded(this.medications);

  @override
  List<Object> get props => [medications];
}

class MedicationError extends MedicationState {
  final String message;

  const MedicationError(this.message);

  @override
  List<Object> get props => [message];
}
