part of 'appointments_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<Appointment> appointments;

  const AppointmentLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object> get props => [message];
}

class AppointmentAdded extends AppointmentState {
  final String appointmentId;
  final List<Appointment> appointments;

  const AppointmentAdded(this.appointmentId, this.appointments);

  @override
  List<Object> get props => [appointmentId, appointments];
}
