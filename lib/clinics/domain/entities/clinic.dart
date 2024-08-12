import 'package:equatable/equatable.dart';

class Clinic extends Equatable {
  final String name;
  final String? imageUrl;
  final List<int> doctors;
  final String id;
  const Clinic(
      {required this.name,
      this.imageUrl,
      required this.doctors,
      required this.id});

  @override
  List<Object?> get props => [name, imageUrl, doctors, id];
}
