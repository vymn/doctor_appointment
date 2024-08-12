import '../entities/clinic.dart';

abstract class ClinicRepository {
  Future<List<Clinic>> getClinics();
  // Future<List<Doctor>> getClinicsDoctors({required int clinicId});
}
