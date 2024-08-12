import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createMockData() async {
  // Reference to Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Clear existing data (optional)
  await _clearExistingData(firestore);

  // Create mock clinics
  List<String> clinicIds = [];
  for (int i = 1; i <= 5; i++) {
    DocumentReference clinicRef = await firestore.collection('clinics').add({
      'name': 'Clinic $i',
      'location': 'Location $i',
    });
    clinicIds.add(clinicRef.id);
  }

  // Create mock doctors
  for (String clinicId in clinicIds) {
    List<String> doctorIds = [];
    for (int i = 1; i <= 3; i++) {
      DocumentReference doctorRef = await firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .add({
        'name': 'Doctor $i',
        'specialization': 'Specialization $i',
        'phoneNumber': '123-456-789$i',
      });
      doctorIds.add(doctorRef.id);
    }

    // Create mock appointments for each doctor
    for (String doctorId in doctorIds) {
      for (int i = 1; i <= 2; i++) {
        await firestore
            .collection('clinics')
            .doc(clinicId)
            .collection('doctors')
            .doc(doctorId)
            .collection('appointments')
            .add({
          'patientName': 'Patient $i',
          'patientPhone': '987-654-321$i',
          'patientAge': '${20 + i}',
          'appointmentDay': 'Monday',
          'appointmentId': 'appt-${clinicId.substring(0, 5)}-$doctorId-$i',
        });
      }
    }
  }
}

Future<void> _clearExistingData(FirebaseFirestore firestore) async {
  // Clear clinics collection
  QuerySnapshot clinicSnapshot = await firestore.collection('clinics').get();
  for (QueryDocumentSnapshot clinicDoc in clinicSnapshot.docs) {
    // Clear doctors subcollection
    QuerySnapshot doctorSnapshot = await firestore
        .collection('clinics')
        .doc(clinicDoc.id)
        .collection('doctors')
        .get();
    for (QueryDocumentSnapshot doctorDoc in doctorSnapshot.docs) {
      // Clear appointments subcollection
      QuerySnapshot appointmentSnapshot = await firestore
          .collection('clinics')
          .doc(clinicDoc.id)
          .collection('doctors')
          .doc(doctorDoc.id)
          .collection('appointments')
          .get();
      for (QueryDocumentSnapshot appointmentDoc in appointmentSnapshot.docs) {
        await appointmentDoc.reference.delete();
      }
      await doctorDoc.reference.delete();
    }
    await clinicDoc.reference.delete();
  }
}
