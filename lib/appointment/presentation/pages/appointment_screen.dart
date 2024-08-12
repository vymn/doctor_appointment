import 'package:doctor_app/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';

import '../../../core/styles/colors.dart';
import '../../domain/entities/appointment.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final Uuid _uuid = const Uuid();
  String? _name;
  String? _phoneNumber;
  int? _age;
  final String _selectedDay = 'Monday';
  String? _appointmentId;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  ScreenshotController screenshotController = ScreenshotController();
  final _formFieldDecoration = InputDecoration(
    border: InputBorder.none,
    filled: true,
    fillColor: Color(
      MyColors.bg,
    ),
    hintStyle: TextStyle(
        fontSize: 13,
        color: Color(MyColors.purple01),
        fontWeight: FontWeight.w700),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointment'),
      ),
      body: BlocProvider<AppointmentBloc>(
          create: (_) => AppointmentBloc(),
          child: BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration: _formFieldDecoration.copyWith(
                            labelText: 'قم بإدخال إسمك'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'رجاءا قم بإدخال إسمك';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration: _formFieldDecoration.copyWith(
                            labelText: 'قم بإدخال رقم هاتفك'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ' رجاءا قم بإدخال رقم هاتفك';
                          }
                          return null;
                        },
                        onSaved: (value) => _phoneNumber = value,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration: _formFieldDecoration.copyWith(
                            labelText: 'قم بإدخال عمرك'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'رجاءا قم بإدخال عمرك';
                          }
                          return null;
                        },
                        onSaved: (value) => _age = int.tryParse(value!),
                      ),
                      const SizedBox(height: 20),
                      const Text('إختر يوم للمقابله', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      // Container(
                      //   height: 150,
                      //   child: CupertinoPicker(
                      //     itemExtent: 32.0,
                      //     onSelectedItemChanged: (int index) {
                      //       setState(() {
                      //         _selectedDay = _days[index];
                      //       });
                      //     },
                      //     children: _days.map((String day) {
                      //       return Center(child: Text(day));
                      //     }).toList(),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _appointmentId = _uuid.v4();
                            context.read<AppointmentBloc>().add(
                                CreateAppointmentEvent(
                                    appointment: Appointment(
                                        doctorId: 7,
                                        id: _appointmentId!,
                                        patientName: _name!,
                                        patientAge: _age!,
                                        patientPhone: _phoneNumber!)));
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text('Appointment Confirmed'),
                                  ),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Appointment ID: $_appointmentId'),
                                      const SizedBox(height: 20),
                                      if (_appointmentId != null)
                                        SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: QrImageView(
                                            data: _appointmentId!,
                                            version: QrVersions.auto,
                                            size: 200.0,
                                          ),
                                        )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Save QR Code'),
                                      onPressed: () async {
                                        final directory =
                                            (await getApplicationDocumentsDirectory())
                                                .path;
                                        String fileName = '$_appointmentId.png';
                                        screenshotController
                                            .captureAndSave(directory,
                                                fileName: fileName)
                                            .then((String? path) {
                                          if (path != null) {
                                            ImageGallerySaver.saveFile(path)
                                                .then((result) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'QR Code saved to gallery')),
                                              );
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
