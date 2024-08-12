import 'package:bloc/bloc.dart';
import 'package:doctor_app/appointment/data/repository/appointment_repository_impl.dart';
import 'package:doctor_app/appointment/domain/usecases/assign_appointment_usecase.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/appointment.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AssignAppointmentUsecase _created_appointment =
      AssignAppointmentUsecase(AppointmentRepositoryImpl());
  AppointmentBloc() : super(AppointmentInitial()) {
    on<AppointmentEvent>((event, emit) async {
      if (event is CreateAppointmentEvent) {
        final result = await _created_appointment(event.appointment);
      }
    });
  }
}
