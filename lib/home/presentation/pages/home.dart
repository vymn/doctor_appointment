import 'package:doctor_app/clinics/presentation/clinic_bloc.dart';
import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:doctor_app/doctors/presentation/pages/doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/styles/colors.dart';
import '../widgets/app_bar.dart';
import '../widgets/clincs_icons.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ClinicBloc>().add(const GetClinicsEvent());
    context.read<DoctorsBloc>().add(const GetAllDoctorsEvent());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const EgoAppBar(),
            const SizedBox(
              height: 40,
            ),
            Text(
              'العيادات التخصصيه',
              style: TextStyle(
                  color: Color(MyColors.header01),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const ClinicsIcons(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'أميز الاطباء',
              style: TextStyle(
                  color: Color(MyColors.header01),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<DoctorsBloc, DoctorsState>(
              builder: (context, state) {
                if (state is DoctorsLoading || state is DoctorsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DoctorsLoaded) {
                  if (state.doctors.isEmpty) {
                    return const Center(
                      child: Text(
                          'لا يوجد اطباء في هذه العياده الرجاء اختيار عياده اخري'),
                    );
                  }

                  return DoctorsScreen(doctors: state.doctors);
                }
                return const SizedBox();
              },
              listener: (BuildContext context, DoctorsState state) {
                if (state is DoctorsInitial) {
                  context.read<DoctorsBloc>().add(const GetAllDoctorsEvent());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
