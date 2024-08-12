import 'package:doctor_app/appointment/domain/entities/appointment.dart';
import 'package:doctor_app/core/usecase/usecase.dart';

import '../repository/appointment_repository.dart';

class GetAllAppointmentsUsecase extends Usecase<List<Appointment>, NoParam> {
  final AppointmentRepository _appointmentRepository;
  const GetAllAppointmentsUsecase(this._appointmentRepository);

  @override
  Future<List<Appointment>> call(NoParam param) async {
    return await _appointmentRepository.getAllAppointments();
  }
}
