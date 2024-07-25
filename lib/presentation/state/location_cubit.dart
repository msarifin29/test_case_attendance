import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/geolocator_manager.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final Position position;
  const LocationSuccess({required this.position});

  @override
  List<Object> get props => [position];

  @override
  String toString() {
    return 'LocationSuccess{position: $position}';
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
      final position = await GeolocatorManager.determinePosition();
      emit(LocationSuccess(position: position));
    } catch (e) {
      emit(LocationFailure(msg: e.toString()));
    }
  }
}
