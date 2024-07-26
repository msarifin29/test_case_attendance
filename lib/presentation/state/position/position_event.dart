// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'position_bloc.dart';

sealed class PositionEvent extends Equatable {
  const PositionEvent();

  @override
  List<Object> get props => [];
}

class StartPositionStream extends PositionEvent {
  final double lat;
  final double long;
  const StartPositionStream({
    required this.lat,
    required this.long,
  });
  @override
  List<Object> get props => [lat, long];
}

class PositionUpdated extends PositionEvent {
  final LocationData locationData;
  final double lat;
  final double long;
  const PositionUpdated({
    required this.locationData,
    required this.lat,
    required this.long,
  });

  @override
  List<Object> get props => [locationData];
}
