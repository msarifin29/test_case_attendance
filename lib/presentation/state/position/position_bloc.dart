// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:attendance/core/service_location.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:location/location.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc() : super(PositionInitial()) {
    on<StartPositionStream>(
      (event, emit) async {
        emit(PositionLoading());
        await emit.onEach<LocationData>(
          ServiceLocation.streamLocation(),
          onData: (locationData) => add(
            PositionUpdated(
              locationData: locationData,
              lat: event.lat,
              long: event.long,
            ),
          ),
          onError: (error, stackTrace) => emit(
            PositionError(error.toString()),
          ),
        );
      },
      transformer: restartable(),
    );
    on<PositionUpdated>(
      (event, emit) => emit(
        PositionLoaded(
          locationData: event.locationData,
          lat: event.lat,
          long: event.long,
        ),
      ),
    );
  }
}
