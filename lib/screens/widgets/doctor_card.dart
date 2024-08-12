import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String imageUrl;
  final isAvailable;
  const DoctorCard(
      {super.key,
      required this.doctorName,
      required this.specialization,
      required this.imageUrl,
      this.isAvailable = true});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      width: size.width * .9,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.5),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                doctorName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                specialization,
                style: const TextStyle(fontSize: 14),
              ),
              InkWell(
                child: Chip(
                  label: const Text('Appointment'),
                  backgroundColor: Colors.grey[100],
                  side: BorderSide.none,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
