import '../repository/clinic_repository.dart';

import '../entities/clinic.dart';

class GetClinicsUsecase {
  final ClinicRepository _clinicRepository;
  const GetClinicsUsecase(this._clinicRepository);

  Future<List<Clinic>> call() async {
    return await _clinicRepository.getClinics();
  }

  // Future<List<Doctor>> getClinicDoctorsUsecaseUse(int clinicId) async {
  //   // return await GetClinicDoctorsUsecase(clinicId);
  // }
}
