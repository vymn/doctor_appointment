import 'package:doctor_app/core/usecase/usecase.dart';
import 'package:doctor_app/doctors/domain/repository/doctors_repository.dart';

import '../entities/doctor.dart';

class GetAllDoctorsUsecase extends Usecase<List<Doctor>, NoParam> {
  final DoctorsRepository _clinicRepository;
  const GetAllDoctorsUsecase(this._clinicRepository);

  @override
  Future<List<Doctor>> call(NoParam) async {
    return await _clinicRepository.getAllDoctors();
  }
}
