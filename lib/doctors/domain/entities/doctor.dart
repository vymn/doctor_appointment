import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String name;
  final String specialty;
  final int? yearsOfExperience;
  final int clinicId;
  final String id;
  final String? image;
  final List<int>? patientsIds;
  final String? about;
  final List<int>? workingDays;
  const Doctor({
    required this.id,
    this.patientsIds,
    required this.name,
    required this.specialty,
    required this.yearsOfExperience,
    required this.clinicId,
    this.image,
    this.about,
    this.workingDays,
  });

  @override
  List<Object?> get props =>
      [name, specialty, yearsOfExperience, clinicId, id, patientsIds, about];
}
