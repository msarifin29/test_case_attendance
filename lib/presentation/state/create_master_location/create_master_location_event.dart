// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_master_location_bloc.dart';

sealed class CreateMasterLocationEvent extends Equatable {
  const CreateMasterLocationEvent();

  @override
  List<Object> get props => [];
}

class OnCreated extends CreateMasterLocationEvent {
  const OnCreated({
    required this.lat,
    required this.long,
  });
  final double lat;
  final double long;
  @override
  List<Object> get props => [lat, long];
}

class FetchmasterLocation extends CreateMasterLocationEvent {
  const FetchmasterLocation({required this.locationUser});
  final LocationUser locationUser;
  @override
  List<Object> get props => [locationUser];
}
