import 'package:doctor_app/appointment/domain/entities/appointment.dart';
import 'package:doctor_app/core/usecase/usecase.dart';

import '../repository/appointment_repository.dart';

class GetAppointmentByIdUsecase extends Usecase<Appointment, String> {
  final AppointmentRepository _appointmentRepository;
  const GetAppointmentByIdUsecase(this._appointmentRepository);

  @override
  Future<Appointment> call(String appointmentId) async {
    return await _appointmentRepository.getAppointmentById(
        appointmentId: appointmentId);
  }
}
