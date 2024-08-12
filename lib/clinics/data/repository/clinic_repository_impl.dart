import 'package:doctor_app/clinics/domain/entities/clinic.dart';
import 'package:doctor_app/clinics/domain/repository/clinic_repository.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  @override
  Future<List<Clinic>> getClinics() async {
    final snapshots =
        await FirebaseFirestore.instance.collection('clinics').get();
    return snapshots.docs
        .map((doc) => Clinic(
              name: doc.data()['name'] as String,
              // imageUrl: doc.data()['imageUrl'] as String,
              doctors: const [],
              id: doc.id,
            ))
        .toList();
    // return [];

    // return [
    //   const Clinic(
    //     name: 'الاطفال',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 0,
    //   ),
    //   const Clinic(
    //     name: 'محجر العيون',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 1,
    //   ),
    //   const Clinic(
    //     name: 'الحول',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 2,
    //   ),
    //   const Clinic(
    //     name: 'الجلاكوما',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 3,
    //   ),
    //   const Clinic(
    //     name: 'الشبكيه',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 4,
    //   ),
    //   const Clinic(
    //     name: 'القرنيه',
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0ap2wNEi_R6j-cQG0cpZ1DmM146m8evJC0XxXa9cQkB5WFPJGPNwYYZl2xFRJeeoWtJY&usqp=CAU',
    //     doctors: [],
    //     id: 5,
    //   ),
    // ];
  }
}
