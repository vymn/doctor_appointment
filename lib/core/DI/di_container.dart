import 'package:doctor_app/clinics/data/repository/clinic_repository_impl.dart';
import 'package:doctor_app/clinics/domain/repository/clinic_repository.dart';
import 'package:doctor_app/clinics/domain/usecases/get_clinics_usecase.dart';
import 'package:doctor_app/clinics/presentation/clinic_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initInjection(sl);
}

void initInjection(GetIt sl) {
  // register Presentation layer

  sl.registerFactory(() => ClinicBloc());

  // register domain layer
  sl.registerLazySingleton(() => GetClinicsUsecase(sl()));
  // register repositoryp
  sl.registerLazySingleton<ClinicRepository>(() => ClinicRepositoryImpl());
}
