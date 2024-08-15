import 'package:doctor_app/auth/login_screen.dart';
import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../clinics/presentation/clinic_bloc.dart';
import '../../../core/styles/colors.dart';
import 'home.dart';
import '../../../doctors/presentation/pages/ScheduleTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider<ClinicBloc>(create: (_) => ClinicBloc()),
          BlocProvider<DoctorsBloc>(create: (_) => DoctorsBloc()),
        ],
        child: const HomeTab(),
      )),
    );
  }
}
