import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/core/common/widgets/widgets.dart';
import 'package:doctor_app/core/functions/helpers.dart';
import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/styles/colors.dart';
import '../../../core/styles/styles.dart';
import '../../domain/entities/doctor.dart';

class SliverDoctorDetail extends StatelessWidget {
  final Doctor doctor;
  const SliverDoctorDetail({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (_) => DoctorsBloc(),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  // pinned: true,
                  title: Text(
                    'تفاصيل الطبيب',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // backgroundColor: Color(MyColors.primary),
                  // expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                      // background: DetailDoctorCard(doctor: doctor),
                      // background: Image(
                      //   image: AssetImage('assets/hospital.jpeg'),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                ),
                SliverToBoxAdapter(
                  child: DetailBody(
                    doctor: doctor,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class DetailBody extends StatelessWidget {
  final Doctor doctor;
  const DetailBody({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<DoctorsBloc>().add(GetDoctorById(doctor));
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(
            doctor: doctor,
          ),
          const SizedBox(
            height: 15,
          ),
          // const DoctorInfo(),
          const SizedBox(
            height: 30,
          ),
          Text(
            'عن الطبيب',
            style: kTitleStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            doctor.about != null ? doctor.about! : "",
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'أيام العمل',
            style: kTitleStyle,
          ),
          const SizedBox(
            height: 25,
          ),

          WeekDays(
            doctorWorkingDays: doctor.workingDays!,
            isRegestration: false,
            onSelectedDaysChanged: (List<int> value) {},
          ),
          // DoctorLocation(),
          const SizedBox(
            height: 120,
          ),
          EgoButton(
            text: 'احجز موعد',
            width: 220,
            backgroundColor: Color(MyColors.primary),
            onPressed: () => {
              // Navigator.push(context, MaterialPageRoute(builder: (_)=> DoctorAppointments()))
              // showDialog(context: context, builder: (_) => AppointmentScreen())
              _showAppointmentDialog(
                  context, doctor.id, '1', doctor.workingDays!)
            },
          )
          // EgoButton(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStateProperty.all<Color>(
          //       Color(MyColors.primary),
          //     ),
          //   ),
          //   child: const Text(
          //     'Book Appointment',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onPressed: () => {
          //     // Navigator.push(context, MaterialPageRoute(builder: (_)=> DoctorAppointments()))
          //     // showDialog(context: context, builder: (_) => AppointmentScreen())
          //     _showAppointmentDialog(context, doctor.id, '1')
          //   },
          // )
        ],
      ),
    );
    // return BlocBuilder<DoctorsBloc, DoctorsState>(builder: (context, state) {
    //   print(state.toString());
    //   if (state is DoctorLoading) {
    //     return const Center(child: CircularProgressIndicator());
    //   } else if (state is DoctorLoaded) {
    //     return Container(
    //       padding: const EdgeInsets.all(20),
    //       margin: const EdgeInsets.only(bottom: 30),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           DetailDoctorCard(
    //             doctor: state.doctor,
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           // const DoctorInfo(),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           Text(
    //             'About Doctor',
    //             style: kTitleStyle,
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           Text(
    //             'Dr. Ayman Mohammed lorem  dolor lore mauris lore mauris lore mauris lore mauris lore mauris lore mauris',
    //             style: TextStyle(
    //               color: Color(MyColors.purple01),
    //               fontWeight: FontWeight.w500,
    //               height: 1.5,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           // Text(
    //           //   'Location',
    //           //   style: kTitleStyle,
    //           // ),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           // DoctorLocation(),
    //           const SizedBox(
    //             height: 25,
    //           ),
    //           ElevatedButton(
    //             style: ButtonStyle(
    //               backgroundColor: WidgetStateProperty.all<Color>(
    //                 Color(MyColors.primary),
    //               ),
    //             ),
    //             child: const Text(
    //               'Book Appointment',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () => {
    //               showDialog(
    //                   context: context, builder: (_) => AppointmentScreen())
    //             },
    //           )
    //         ],
    //       ),
    //     );
    //   }
    //
    //   return Center(child: Text('there is a problem loading the doctors'));
    // });
  }
}

// class DoctorLocation extends StatelessWidget {
//   const DoctorLocation({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 200,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         // child: FlutterMap(
//         //   options: MapOptions(
//         //     center: latLng.LatLng(51.5, -0.09),
//         //     zoom: 13.0,
//         //   ),
//         //   layers: [
//         //     TileLayerOptions(
//         //       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//         //       subdomains: ['a', 'b', 'c'],
//         //     ),
//         //   ],
//         // ),
//       ),
//     );
//   }
// }

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NumberCard(
          label: 'عدد المرضى',
          value: '100+',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Experiences',
          value: '10 years',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Rating',
          value: '4.0',
        ),
      ],
    );
  }
}

class WeekDays extends StatefulWidget {
  const WeekDays({
    super.key,
    required this.onSelectedDaysChanged,
    required this.doctorWorkingDays,
    this.isRegestration = false,
  });
  final ValueChanged<List<int>> onSelectedDaysChanged;
  final List<int> doctorWorkingDays;
  final bool isRegestration;

  @override
  _WeekDaysState createState() => _WeekDaysState();
}

class _WeekDaysState extends State<WeekDays> {
  final List<String> days = ['أح', 'إ', 'ث', 'أر', 'خ', 'ج', 'س'];
  // final List<bool> selected = List.generate(7, (index) => false);
  late final List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected =
        List.generate(7, (index) => widget.doctorWorkingDays.contains(index));
    print(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // textDirection: TextDirection.ltr,
      children: days.asMap().entries.map((entry) {
        print(entry.value);
        int idx = entry.key;
        String day = entry.value;
        return Expanded(
          child: GestureDetector(
            onTap: widget.isRegestration
                ? () {
                    setState(() {
                      selected[idx] = !selected[idx];
                      widget.onSelectedDaysChanged(selected
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList());
                    });
                  }
                : () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: selected[idx]
                    ? Color(MyColors.primary)
                    : Color(MyColors.bg03),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      color: selected[idx] ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final String title;
  final String desc;
  const AboutDoctor({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DetailDoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(MyColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //     radius: 40,
                  //     backgroundImage: doctor.image != null
                  //         ? NetworkImage(doctor.image!)
                  //         : const AssetImage('assets/images/doctor.png')),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        doctor.specialty,
                        style: TextStyle(
                            color: Color(MyColors.text01), fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // const ScheduleCard(),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAppointmentDialog(BuildContext context, String doctorId,
    String clinicId, List<int> workingDays) {
  int? appointmentDay = workingDays[0];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  final List<String> weekDays = [
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعه',
    'السبت'
  ];
  final List<String> doctorWorkingDays =
      workingDays.map((day) => weekDays[day]).toList();

  showBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Form(
        key: _keyForm,
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: EgoText(
                    text: 'الرجاء ادخال بيانات الحجز',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                EgoTextForm(
                  controller: nameController,
                  hintText: 'الإسم',
                  validator: requiredValidator.call,
                ),
                const SizedBox(
                  height: 12,
                ),
                EgoTextForm(
                  controller: phoneController,
                  hintText: 'رقم الهاتف',
                  keyboardType: TextInputType.phone,
                  validator: requiredValidator,
                ),
                const SizedBox(
                  height: 12,
                ),
                EgoTextForm(
                  controller: ageController,
                  hintText: 'العمر',
                  keyboardType: TextInputType.number,
                  validator: requiredValidator,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(height: 20),
                const EgoText(
                  text: 'اختر يوم للحجز:',
                  fontWeight: FontWeight.bold,
                ),
                // DropdownButtonFormField<String>(
                //   items: [
                //     DropdownMenuItem(child: Text("Monday"), value: "Monday"),
                //     DropdownMenuItem(child: Text("Tuesday"), value: "Tuesday"),
                //     DropdownMenuItem(
                //         child: Text("Wednesday"), value: "Wednesday"),
                //     DropdownMenuItem(child: Text("Thursday"), value: "Thursday"),
                //     DropdownMenuItem(child: Text("Friday"), value: "Friday"),
                //     DropdownMenuItem(child: Text("Saturday"), value: "Saturday"),
                //     DropdownMenuItem(child: Text("Sunday"), value: "Sunday"),
                //   ],
                //   onChanged: (String? value) {
                //     _appointmentDay = value;
                //   },
                //   decoration: InputDecoration(labelText: "Select Day"),
                // ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 150,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int index) {
                      appointmentDay = workingDays[index];
                      // setState(() {
                      //   _selectedDay = _days[index];
                      // }
                      // );
                    },
                    children: doctorWorkingDays.map((String day) {
                      return Center(child: Text(day));
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                EgoButton(
                  text: 'تأكيد الحجز',
                  width: 220,
                  backgroundColor: Color(MyColors.primary),
                  onPressed: () async {
                    var uuid = const Uuid();
                    String appointmentId = uuid.v4();
                    if (_keyForm.currentState!.validate()) {
                      // Reference to the appointments collection for a specific doctor
                      CollectionReference appointmentsRef = FirebaseFirestore
                          .instance
                          .collection('doctors')
                          .doc(doctorId)
                          .collection('appointments');

                      // Query to count the number of appointments on the same day
                      QuerySnapshot querySnapshot = await appointmentsRef
                          .where('appointmentDay', isEqualTo: appointmentDay)
                          .get();

                      if (querySnapshot.docs.length >= 20) {
                        // Prevent the creation of a new appointment if the limit is reached
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'لا يمكنك حجز موعد هذا اليوم الرجاء اختيار موعد اخر')));
                      } else {
                        await FirebaseFirestore.instance
                            .collection('doctors')
                            .doc(doctorId)
                            .collection('appointments')
                            .doc(appointmentId)
                            .set({
                          'patientName': nameController.text,
                          'patientPhone': phoneController.text,
                          'patientAge': ageController.text,
                          'appointmentDay': appointmentDay,
                          'appointmentId': appointmentId,
                          'isCompleted': 0
                        });

                        // Show confirmation dialog with QR code
                        Navigator.of(context).pop();
                        _showConfirmationDialog(context, appointmentId,
                            querySnapshot.docs.length + 1);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showConfirmationDialog(
    BuildContext context, String appointmentId, int appointmentNumber) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text('تم تأكيد الحجز'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text(' رقم الحجز: ${appointmentNumber}')],
        ),
        actions: <Widget>[
          // TextButton(
          //   child: Text('Save QR Code'),
          //   onPressed: () async {
          //     // final directory =
          //     //     (await getApplicationDocumentsDirectory()).path;
          //     // String fileName = '$directory/QRCode.png';
          //     // screenshotController
          //     //     .captureAndSave(directory, fileName: "QRCode.png")
          //     //     .then((value) async {
          //     //   final result = await ImageGallerySaver.saveFile(fileName);
          //     //   print(result);
          //     // });
          //   },
          // ),
          Center(
            child: TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
