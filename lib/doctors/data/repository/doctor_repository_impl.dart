import 'package:doctor_app/doctors/domain/entities/doctor.dart';
import 'package:doctor_app/doctors/domain/repository/doctors_repository.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class DoctorRepositoryImpl extends DoctorsRepository {
  @override
  Future<List<Doctor>> getAllDoctors() async {
    final doctors =
        await FirebaseFirestore.instance.collection('doctors').get();
    return doctors.docs
        .map(
          (doc) => Doctor(
            id: doc.id,
            name: doc.data()['name'],
            specialty: doc.data()['specialization'],
            // yearsOfExperience: doc.data()['phoneNumber'] as int,
            yearsOfExperience: 4,
            clinicId: 1,
            image:
                'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
            about: doc.data()['about'],
          ),
        )
        .toList();

    // return [
    //   const Doctor(
    //       id: 1,
    //       name: 'Dr. Ayman Mohammed',
    //       specialty: 'Heart specialists',
    //       yearsOfExperience: 4,
    //       clinicId: 1,
    //       image:
    //           'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc'),
    //   const Doctor(
    //       id: 1,
    //       name: 'Dr. Ayman Mohammed',
    //       specialty: 'Heart specialists',
    //       yearsOfExperience: 4,
    //       clinicId: 1,
    //       image:
    //           'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc'),
    //   const Doctor(
    //       id: 1,
    //       name: 'Dr. Ayman Mohammed',
    //       specialty: 'Heart specialists',
    //       yearsOfExperience: 4,
    //       clinicId: 1,
    //       image:
    //           'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc'),
    //   const Doctor(
    //       id: 1,
    //       name: 'Dr. Ayman Mohammed',
    //       specialty: 'Heart specialists',
    //       yearsOfExperience: 4,
    //       clinicId: 1,
    //       image:
    //           'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc'),
    // ];
  }

  @override
  Future<List<Doctor>> getClinicDoctors({required String clinicId}) async {
    final doctors = await FirebaseFirestore.instance
        .collection('clinics')
        .doc(clinicId)
        .collection('doctors')
        .get();
    return doctors.docs
        .map(
          (doc) => Doctor(
            // id: '',
            id: doc.id,
            name: doc.data()['name'],
            specialty: doc.data()['specialization'],
            // yearsOfExperience: doc.data()['phoneNumber'],
            yearsOfExperience: 4,
            clinicId: 1,
            image:
                'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc',
            // clinicId: doc.data()['clinicId'],
            // image: doc.data()['image'],
            about: doc.data()['about'],
            workingDays: List<int>.from(doc.data()['workingDays']),
          ),
        )
        .toList();
    // return doctors.docs.map((doc) => Doctor(
    //   id: doc.id,
    //   name: doc.data()['name'],
    //   specialty: doc.data()['specialty'],
    //   yearsOfExperience: doc.data()['yearsOfExperience'],
    //   clinicId: doc.data()['clinicId'],
    //   image: doc.data()['image'],
    // ) );

    // return [
    //   const Doctor(
    //       id: 1,
    //       name: 'name',
    //       specialty: 'specialty',
    //       yearsOfExperience: 4,
    //       clinicId: 1),
    //   const Doctor(
    //       id: 1,
    //       name: 'name',
    //       specialty: 'specialty',
    //       yearsOfExperience: 4,
    //       clinicId: 1),
    //   const Doctor(
    //       id: 1,
    //       name: 'name',
    //       specialty: 'specialty',
    //       yearsOfExperience: 4,
    //       clinicId: 1),
    // ];
  }

  @override
  Future<Doctor> getDoctorById({required String doctorId}) async {
    return const Doctor(
        id: "1",
        name: 'Dr. Ayman Mohammed',
        specialty: 'Heart Specialist',
        yearsOfExperience: 4,
        clinicId: 1,
        image:
            'https://media.licdn.com/dms/image/D4E03AQFaMdhkFrSnBA/profile-displayphoto-shrink_400_400/0/1718284024212?e=1727308800&v=beta&t=Z9P-eejAd2Oc_VbYbgvxUzh35_xNaMqGy-ElgLLMtIc');
  }
}
