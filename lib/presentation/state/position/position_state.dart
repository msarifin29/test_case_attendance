// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'position_bloc.dart';

sealed class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionLoaded extends PositionState {
  final LocationData locationData;
  final double lat;
  final double long;
  const PositionLoaded({
    required this.locationData,
    required this.lat,
    required this.long,
  });

  @override
  List<Object> get props => [locationData, lat, long];
}

class PositionError extends PositionState {
  final String message;

  const PositionError(this.message);

  @override
  List<Object> get props => [message];
}
