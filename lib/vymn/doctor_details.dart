import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DoctorDetailsScreen extends StatelessWidget {
  // String doctorFirebseId = FirebaseAuth.instance.currentUser!.uid;
  final String doctorId;
  final doctor;
  final String clinicId;
  final ScreenshotController screenshotController = ScreenshotController();

  DoctorDetailsScreen(
      {super.key, required this.doctorId, required this.doctor, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    // print(doctorFirebseId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              doctor['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialization: ${doctor['specialization']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone Number: ${doctor['phoneNumber']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showAppointmentDialog(context, doctorId, clinicId);
              },
              child: const Text('Make Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppointmentDialog(
      BuildContext context, String doctorId, String clinicId) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Make Appointment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                const SizedBox(height: 20),
                const Text('Select Appointment Day:'),
                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(value: "Monday", child: Text("Monday")),
                    DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
                    DropdownMenuItem(
                        value: "Wednesday",
                        child: Text("Wednesday")),
                    DropdownMenuItem(
                        value: "Thursday",
                        child: Text("Thursday")),
                    DropdownMenuItem(value: "Friday", child: Text("Friday")),
                    DropdownMenuItem(
                        value: "Saturday",
                        child: Text("Saturday")),
                    DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
                  ],
                  onChanged: (String? value) {},
                  decoration: const InputDecoration(labelText: "Select Day"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                var uuid = const Uuid();
                String appointmentId = uuid.v4();

                // Save appointment to Firestore
                // await FirebaseFirestore.instance
                //     .collection('clinics')
                //     .doc(clinicId)
                //     .collection('doctors')
                //     .doc(doctorId)
                //     .collection('appointments')
                //     .doc(appointmentId)
                //     .set({
                //   'patientName': _nameController.text,
                //   'patientPhone': _phoneController.text,
                //   'patientAge': _ageController.text,
                //   'appointmentDay': "Selected Day",
                //   'appointmentId': appointmentId,
                // });
                await FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(doctorId)
                    .collection('appointments')
                    .doc(appointmentId)
                    .set({
                  'patientName': nameController.text,
                  'patientPhone': phoneController.text,
                  'patientAge': ageController.text,
                  'appointmentDay': "Selected Day",
                  'appointmentId': appointmentId,
                });

                // Show confirmation dialog with QR code
                Navigator.of(context).pop();
                _showConfirmationDialog(context, appointmentId);
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Appointment Confirmed'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Screenshot(
              //   controller: screenshotController,
              //   child: QrImage(
              //     data: appointmentId,
              //     version: QrVersions.auto,
              //     size: 200.0,
              //   ),
              // ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save QR Code'),
              onPressed: () async {
                final directory =
                    (await getApplicationDocumentsDirectory()).path;
                String fileName = '$directory/QRCode.png';
                screenshotController
                    .captureAndSave(directory, fileName: "QRCode.png")
                    .then((value) async {
                  final result = await ImageGallerySaver.saveFile(fileName);
                  print(result);
                });
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
