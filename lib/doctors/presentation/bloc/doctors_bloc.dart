import 'package:bloc/bloc.dart';
import 'package:doctor_app/core/usecase/usecase.dart';
import 'package:doctor_app/doctors/domain/usecases/get_all_doctors_usecase.dart';
import 'package:doctor_app/doctors/domain/usecases/get_doctor_usecase.dart';
import 'package:meta/meta.dart';

import '../../data/repository/doctor_repository_impl.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/usecases/get_clinic_doctors_usecase.dart';

part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  final GetClinicDoctorsUseCase _getClinicDoctorsUseCase =
      GetClinicDoctorsUseCase(DoctorRepositoryImpl());
  final GetAllDoctorsUsecase _getAllDoctorsUsecase =
      GetAllDoctorsUsecase(DoctorRepositoryImpl());
  final GetDoctorUsecase _getDoctorUsecase =
      GetDoctorUsecase(DoctorRepositoryImpl());

  DoctorsBloc() : super(DoctorsInitial()) {
    on<DoctorsEvent>((event, emit) async {
      if (event is GetDoctorsByClinicId) {
        print('im in the get clinic by id');
        emit(DoctorsLoading());
        final result = await _getClinicDoctorsUseCase(event.clinicId);
        print(result);
        emit(DoctorsLoaded(doctors: result));
        print(result);
      }
      if (event is GetAllDoctorsEvent) {
        emit(DoctorsLoading());
        final result = await _getAllDoctorsUsecase(NoParam());
        emit(DoctorsLoaded(doctors: result));
      }
      if (event is GetDoctorById) {
        emit(DoctorLoading());
        final result = await _getDoctorUsecase(event.doctorId);
        emit(DoctorLoaded(doctor: result));
      }
    });
  }
}
