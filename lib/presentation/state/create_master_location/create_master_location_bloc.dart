import 'dart:async';
import 'dart:io';

import 'package:attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:attendance/data/models/location_user.dart';
import 'package:attendance/data/repositories/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_master_location_event.dart';
part 'create_master_location_state.dart';

class CreateMasterLocationBloc
    extends Bloc<CreateMasterLocationEvent, CreateMasterLocationState> {
  final AttendanceRepository repository;
  CreateMasterLocationBloc({required this.repository})
      : super(CreateMasterLocationInitial()) {
    on<OnCreated>((event, emit) async {
      emit(CreateMasterLocationLoading());
      try {
        final success = await repository.createMasterLocation(
          CreateMasterLocationParams(lat: event.lat, long: event.long),
        );
        emit(CreateMasterLocationSuccess(success: success));
      } catch (e) {
        if (e is SocketException) {
          emit(
              const CreateMasterLocationFailure(msg: 'No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const CreateMasterLocationFailure(msg: 'Request time out'));
        } else if (e is TypeError) {
          emit(const CreateMasterLocationFailure(msg: 'Parsing failed'));
        } else {
          emit(const CreateMasterLocationFailure(msg: 'Failed to create todo'));
        }
      }
    });
    on<FetchmasterLocation>((event, emit) async {
      emit(FetchMasterLocationLoading());
      try {
        final locationUser = await repository.fetchMasterLocation();
        emit(FetchMasterLocationSuccess(locationUser: locationUser));
      } catch (e) {
        if (e is SocketException) {
          emit(const FetchMasterLocationFailure(msg: 'No Internet Connection'));
        } else if (e is TimeoutException) {
          emit(const FetchMasterLocationFailure(msg: 'Request time out'));
        } else if (e is TypeError) {
          emit(const FetchMasterLocationFailure(msg: 'Parsing failed'));
        } else {
          emit(const FetchMasterLocationFailure(msg: 'Failed to create todo'));
        }
      }
    });
  }
}
