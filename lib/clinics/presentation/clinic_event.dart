part of 'clinic_bloc.dart';

@immutable
sealed class ClinicEvent {
  const ClinicEvent();
}

class GetClinicsEvent extends ClinicEvent {
  const GetClinicsEvent();
}

class GetClinicByIdEvent extends ClinicEvent {
  final String clinicId;
  const GetClinicByIdEvent({required this.clinicId});
}
