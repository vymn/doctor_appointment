part of 'doctors_bloc.dart';

@immutable
sealed class DoctorsEvent {
  const DoctorsEvent();
}

final class GetAllDoctorsEvent extends DoctorsEvent {
  const GetAllDoctorsEvent();
}

final class GetDoctorsByClinicId extends DoctorsEvent {
  final String clinicId;

  const GetDoctorsByClinicId({required this.clinicId});
}

final class GetDoctorById extends DoctorsEvent {
  final String doctorId;

  const GetDoctorById(this.doctorId);
}
