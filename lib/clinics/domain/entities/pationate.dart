import 'package:equatable/equatable.dart';

class Pationate extends Equatable {
  final String name;
  final String age;
  final String id;
  final String doctorId;
  final String phone;
  const Pationate({
    required this.name,
    required this.age,
    required this.id,
    required this.doctorId,
    required this.phone,
  });
  @override
  List<Object?> get props => [
        name,
        age,
        doctorId,
        phone,
        id,
      ];
}
