part of 'appointments_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  final String userId;

  const LoadAppointments(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddAppointment extends AppointmentEvent {
  final Appointment appointment;

  const AddAppointment(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class UpdateAppointment extends AppointmentEvent {
  final Appointment appointment;
  final String appointmentId;

  const UpdateAppointment(this.appointment, this.appointmentId);

  @override
  List<Object> get props => [appointment, appointmentId];
}

class DeleteAppointment extends AppointmentEvent {
  final String appointmentId;

  const DeleteAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class AppointmentsUpdated extends AppointmentEvent {
  final List<Appointment> appointments;

  const AppointmentsUpdated(this.appointments);

  @override
  List<Object> get props => [appointments];
}
