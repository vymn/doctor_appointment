import '../entities/doctor.dart';

abstract class DoctorsRepository {
  Future<List<Doctor>> getClinicDoctors({required String clinicId});
  Future<List<Doctor>> getAllDoctors();
  Future<Doctor> getDoctorById({required String doctorId});
}
