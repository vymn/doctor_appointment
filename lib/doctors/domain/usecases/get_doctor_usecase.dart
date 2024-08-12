import 'package:doctor_app/core/usecase/usecase.dart';
import 'package:doctor_app/doctors/domain/repository/doctors_repository.dart';

import '../entities/doctor.dart';

class GetDoctorUsecase extends Usecase<Doctor, String> {
  final DoctorsRepository _clinicRepository;
  const GetDoctorUsecase(this._clinicRepository);

  @override
  Future<Doctor> call(String doctorId) async {
    return await _clinicRepository.getDoctorById(doctorId: doctorId);
  }
}
