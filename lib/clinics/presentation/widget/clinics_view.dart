import 'package:doctor_app/clinics/presentation/clinic_bloc.dart';
import 'package:doctor_app/pages/home.dart';
import 'package:doctor_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/clinic.dart';

class ClinicsView extends StatelessWidget {
  const ClinicsView({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild state');
    context.read<ClinicBloc>().add(const GetClinicsEvent());
    return BlocBuilder<ClinicBloc, ClinicState>(builder: (context, state) {
      // if (state is ClinicInitial)
      //    ClinicInitialView();
      if (state is ClinicLoading) {
        const SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is ClinicLoaded) {
        return ClinicListView(clinics: state.clinics);
      } else {
        return Container();
      }
    });
  }
}

class ClinicListView extends StatelessWidget {
  final List<Clinic> clinics;
  const ClinicListView({super.key, required this.clinics});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClinicBloc(),
      child: GridView.builder(
          itemCount: clinics.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                print(clinics[index].name);
                context
                    .read<ClinicBloc>()
                    .add(GetClinicByIdEvent(clinicId: clinics[index].id));
                print('Added GetClinicByIdEvent');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClinicDetailsPage(
                      clinicId: clinics[index].id,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.grey),
                    color: primary),
                // color: Colors.red,
                child: Text(clinics[index].name),
              ),
            );
          }),
    );
  }
}

class ClinicDetailsPage extends StatelessWidget {
  final String clinicId;
  const ClinicDetailsPage({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // context.read<ClinicBloc>().add(GetClinicByIdEvent(clinicId: clinicId));
        return ClinicBloc()..add(GetClinicByIdEvent(clinicId: clinicId));
      },
      child: Scaffold(
        body: BlocBuilder<ClinicBloc, ClinicState>(
          builder: (context, state) {
            // context
            //     .read<ClinicBloc>()
            //     .add(GetClinicByIdEvent(clinicId: clinicId));
            print(state.toString());
            print('im inside the details block');
            print(state.toString());
            if (state is ClinicDoctorLaoding) {
              print('im inside the loading indicator');
              return const CircularProgressIndicator();
            }
            if (state is ClinicsDoctorsLoaded) {
              print('im inside the loaded block');
              print(state.doctors.first.name);
              print(state.toString());
              return Container(
                color: Colors.green,
                child: Center(
                  child: Container(
                      width: 320,
                      height: 320,
                      color: Colors.orange,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const Home()));
                          context
                              .read<ClinicBloc>()
                              .add(const GetClinicsEvent());
                          print(state);
                        },
                        child: Text(
                          state.doctors.first.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}
