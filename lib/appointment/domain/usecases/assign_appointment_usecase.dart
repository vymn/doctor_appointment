import 'package:doctor_app/appointment/domain/entities/appointment.dart';
import 'package:doctor_app/core/usecase/usecase.dart';

import '../repository/appointment_repository.dart';

class AssignAppointmentUsecase extends Usecase<void, Appointment> {
  final AppointmentRepository _appointmentRepository;
  const AssignAppointmentUsecase(this._appointmentRepository);

  @override
  Future<void> call(Appointment appointment) async {
    return await _appointmentRepository.assignNewAppointment(
        appointment: appointment);
  }
}
