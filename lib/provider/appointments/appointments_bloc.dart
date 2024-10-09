import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/provider/appointments/appointments_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;

  AppointmentBloc(this.appointmentRepository) : super(AppointmentLoading()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<AddAppointment>(_onAddAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<DeleteAppointment>(_onDeleteAppointment);
    on<AppointmentsUpdated>(_onAppointmentsUpdated);
  }

  Future<void> _onLoadAppointments(
      LoadAppointments event, Emitter<AppointmentState> emit) async {
    appointmentRepository.getAppointments(event.userId).listen((appointments) {
      add(AppointmentsUpdated(appointments));
    });
  }

  Future<void> _onAddAppointment(
      AddAppointment event, Emitter<AppointmentState> emit) async {
    // add the new appointment and get the appointmentId
    String appointmentId =
        await appointmentRepository.addAppointment(event.appointment);

    // fetch the updated list of appointments
    final appointments = await appointmentRepository
        .getAppointments(event.appointment.userId)
        .first;

    // emit the AppointmentAdded state with both the appointmentId and the updated list of appointments
    emit(AppointmentAdded(appointmentId, appointments));
  }

  Future<void> _onUpdateAppointment(
      UpdateAppointment event, Emitter<AppointmentState> emit) async {
    await appointmentRepository.updateAppointment(
        event.appointment, event.appointmentId);
  }

  Future<void> _onDeleteAppointment(
      DeleteAppointment event, Emitter<AppointmentState> emit) async {
    await appointmentRepository.deleteAppointment(event.appointmentId);
  }

  void _onAppointmentsUpdated(
      AppointmentsUpdated event, Emitter<AppointmentState> emit) {
    emit(AppointmentLoaded(event.appointments));
  }
}
