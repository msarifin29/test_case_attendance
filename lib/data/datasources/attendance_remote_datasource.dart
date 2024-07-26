import 'dart:async';
import 'dart:io';

import 'package:attendance/data/models/attendance_response.dart';
import 'package:attendance/data/models/location_user.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AttendanceRemoteDatasource {
  Future<bool> createMasterLocation(CreateMasterLocationParams params);
  Future<LocationUser> fetchMasterLocation();
  Future<bool> createAttendance(CreateAttendanceParams params);
  Future<AttendanceHistoriesResponse> historiesAttendance();
}

class AttendanceRemoteDatasourceImpl implements AttendanceRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Future<bool> createAttendance(CreateAttendanceParams params) async {
    try {
      await supabase
          .from('attendances')
          .insert({'radius': params.radius, 'status': params.status});

      return true;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<bool> createMasterLocation(CreateMasterLocationParams params) async {
    try {
      await supabase.from('location').insert(params.toMap());
      return true;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<LocationUser> fetchMasterLocation() async {
    try {
      final locationUser =
          await supabase.from('attendances').select().limit(1).single();
      return LocationUser.fromMap(locationUser);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }

  @override
  Future<AttendanceHistoriesResponse> historiesAttendance() async {
    try {
      final histories = await supabase.from('attendances').select();
      return AttendanceHistoriesResponse(histories: histories);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection: ${e.toString()}');
      } else if (e is TimeoutException) {
        throw Exception('Request timed out : ${e.toString()}');
      } else if (e is TypeError) {
        throw Exception("Parsing failed : ${e.toString()}");
      } else {
        throw Exception('Failed to create todo: ${e.toString()}');
      }
    }
  }
}

class CreateMasterLocationParams extends Equatable {
  final double lat;
  final double long;
  const CreateMasterLocationParams({required this.lat, required this.long});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'lat': lat, 'long': long};
  }

  @override
  List<Object?> get props => [lat, long];
}

class CreateAttendanceParams extends Equatable {
  final double radius;
  final String status;
  const CreateAttendanceParams({required this.radius, required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'radius': radius, 'status': status};
  }

  @override
  List<Object?> get props => [radius, status];
}
