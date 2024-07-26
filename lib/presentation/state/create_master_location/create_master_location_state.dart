part of 'create_master_location_bloc.dart';

sealed class CreateMasterLocationState extends Equatable {
  const CreateMasterLocationState();

  @override
  List<Object> get props => [];
}

final class CreateMasterLocationInitial extends CreateMasterLocationState {}

final class CreateMasterLocationLoading extends CreateMasterLocationState {}

final class CreateMasterLocationSuccess extends CreateMasterLocationState {
  final bool success;
  const CreateMasterLocationSuccess({required this.success});
  @override
  List<Object> get props => [success];
}

final class CreateMasterLocationFailure extends CreateMasterLocationState {
  final String msg;
  const CreateMasterLocationFailure({required this.msg});
}

final class FetchMasterLocationLoading extends CreateMasterLocationState {}

final class FetchMasterLocationSuccess extends CreateMasterLocationState {
  final LocationUser locationUser;
  const FetchMasterLocationSuccess({required this.locationUser});
  @override
  List<Object> get props => [locationUser];
}

final class FetchMasterLocationFailure extends CreateMasterLocationState {
  final String msg;
  const FetchMasterLocationFailure({required this.msg});
}
