import 'package:bloc/bloc.dart';
import 'package:doctor_app/clinics/data/repository/clinic_repository_impl.dart';
import 'package:doctor_app/doctors/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

import '../domain/entities/clinic.dart';
import '../domain/usecases/get_clinics_usecase.dart';

part 'clinic_event.dart';
part 'clinic_state.dart';

class ClinicBloc extends Bloc<ClinicEvent, ClinicState> {
  final GetClinicsUsecase _getClinic =
      GetClinicsUsecase(ClinicRepositoryImpl());

  ClinicBloc() : super(ClinicInitial()) {
    on<ClinicEvent>((event, emit) async {
      if (event is GetClinicsEvent) {
        emit(ClinicLoading());
        final result = await _getClinic();
        emit(ClinicLoaded(clinics: result));
        print(result);
      }
    });
  }
}
