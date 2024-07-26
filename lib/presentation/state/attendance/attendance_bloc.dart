import 'dart:async';
import 'dart:io';

import 'package:attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:attendance/data/models/attendance_response.dart';
import 'package:attendance/data/repositories/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repository;
  AttendanceBloc({required this.repository}) : super(AttendanceInitial()) {
    on<CreatedAttendance>((event, emit) async {
      emit(CreateAttendanceLoading());
      try {
        final success = await repository.createAttendance(
          CreateAttendanceParams(radius: event.radius, status: event.status),
        );
        emit(CreateAttendanceSuccess(success: success));
      } catch (e) {
        if (e is SocketException) {
          emit(const CreateAttendanceFailure(msg: 'No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const CreateAttendanceFailure(msg: 'Request time out'));
        } else if (e is TypeError) {
          emit(const CreateAttendanceFailure(msg: 'Parsing failed'));
        } else {
          emit(const CreateAttendanceFailure(msg: 'Failed to create todo'));
        }
      }
    });
    on<Histories>((event, emit) async {
      emit(HistoriesLoading());
      try {
        final response = await repository.historiesAttendance();
        emit(HistoriesSuccess(response: response));
      } catch (e) {
        if (e is SocketException) {
          emit(const HistoriresFailure(msg: 'No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const HistoriresFailure(msg: 'Request time out'));
        } else if (e is TypeError) {
          emit(const HistoriresFailure(msg: 'Parsing failed'));
        } else {
          emit(const HistoriresFailure(msg: 'Failed to create todo'));
        }
      }
    });
  }
}
