import 'package:attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:attendance/data/repositories/attendance_repository.dart';
import 'package:attendance/presentation/state/attendance/attendance_bloc.dart';
import 'package:get_it/get_it.dart';

import 'presentation/state/create_master_location/create_master_location_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<AttendanceRemoteDatasource>(
    () => AttendanceRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton(() => CreateMasterLocationBloc(repository: sl()));
  sl.registerLazySingleton(() => AttendanceBloc(repository: sl()));
}
