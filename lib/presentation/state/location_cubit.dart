import 'package:attendance/core/geolocator_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final Position locationData;
  const LocationSuccess({required this.locationData});

  @override
  List<Object> get props => [locationData];

  @override
  String toString() {
    return 'LocationSuccess{locationData: $locationData}';
  }
}

class LocationFailure extends LocationState {
  final String msg;
  const LocationFailure({required this.msg});

  @override
  List<Object> get props => [msg];

  @override
  String toString() {
    return 'LocationFailure{msg: $msg}';
  }
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  void currentLocation() async {
    emit(LocationLoading());
    try {
      final locationData = await GeolocatorManager.determinePosition();
      emit(LocationSuccess(locationData: locationData));
    } catch (e) {
      emit(LocationFailure(msg: e.toString()));
    }
  }
}
