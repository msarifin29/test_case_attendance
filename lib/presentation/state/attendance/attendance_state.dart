part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class CreateAttendanceLoading extends AttendanceState {}

final class CreateAttendanceSuccess extends AttendanceState {
  final bool success;
  const CreateAttendanceSuccess({required this.success});
  @override
  List<Object> get props => [success];
}

final class CreateAttendanceFailure extends AttendanceState {
  final String msg;
  const CreateAttendanceFailure({required this.msg});
}

final class HistoriesLoading extends AttendanceState {}

final class HistoriesSuccess extends AttendanceState {
  final AttendanceHistoriesResponse response;
  const HistoriesSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class HistoriresFailure extends AttendanceState {
  final String msg;
  const HistoriresFailure({required this.msg});
}
