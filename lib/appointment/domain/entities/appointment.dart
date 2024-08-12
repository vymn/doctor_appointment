
class Appointment {
  final String id;
  final String patientName;
  final String patientPhone;
  final int patientAge;
  final int doctorId;
  const Appointment({
    required this.id,
    required this.patientName,
    required this.patientPhone,
    required this.patientAge,
    required this.doctorId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        patientName: json['patientName'],
        patientPhone: json['patientPhone'],
        patientAge: json['patientAge'],
        doctorId: json['doctorId'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'patientAge': patientAge,
      'doctorId': doctorId,
    };

    //   from json
  }
}
