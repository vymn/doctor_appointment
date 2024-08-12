import 'package:doctor_app/core/usecase/usecase.dart';
import 'package:doctor_app/doctors/domain/repository/doctors_repository.dart';

import '../entities/doctor.dart';

class GetClinicDoctorsUseCase extends Usecase<List<Doctor>, String> {
  final DoctorsRepository _clinicRepository;
  const GetClinicDoctorsUseCase(this._clinicRepository);

  @override
  Future<List<Doctor>> call(String clinicId) async {
    return await _clinicRepository.getClinicDoctors(clinicId: clinicId);
  }
}
