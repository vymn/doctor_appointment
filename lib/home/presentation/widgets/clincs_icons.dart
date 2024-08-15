import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../clinics/presentation/clinic_bloc.dart';
import 'clinic_icon.dart';

class ClinicsIcons extends StatelessWidget {
  const ClinicsIcons({
    super.key,
    // required this.clinics,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    return BlocBuilder<ClinicBloc, ClinicState>(builder: (context, state) {
      if (state is ClinicLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ClinicLoaded) {
        return SizedBox(
          width: width,
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var clinic in state.clinics)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClinicIcon(
                    id: clinic.id,
                    icon: Icons.local_pharmacy,
                    text: clinic.name,
                  ),
                )
            ],
          ),
        );
      } else {
        return const Center(
          child: Text('there is no clinics available'),
        );
      }
    });
  }
}
