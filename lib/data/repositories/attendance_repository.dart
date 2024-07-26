// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:attendance/data/models/attendance_response.dart';
import 'package:attendance/data/models/location_user.dart';

abstract class AttendanceRepository {
  Future<bool> createMasterLocation(CreateMasterLocationParams params);
  Future<LocationUser> fetchMasterLocation();
  Future<bool> createAttendance(CreateAttendanceParams params);
  Future<AttendanceHistoriesResponse> historiesAttendance();
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDatasource datasource;
  AttendanceRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<bool> createAttendance(CreateAttendanceParams params) async {
    return await datasource.createAttendance(params);
  }

  @override
  Future<bool> createMasterLocation(CreateMasterLocationParams params) async {
    return await datasource.createMasterLocation(params);
  }

  @override
  Future<LocationUser> fetchMasterLocation() async {
    return await datasource.fetchMasterLocation();
  }

  @override
  Future<AttendanceHistoriesResponse> historiesAttendance() async {
    return await datasource.historiesAttendance();
  }
}
