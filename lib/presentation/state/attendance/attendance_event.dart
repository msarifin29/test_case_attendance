part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class CreatedAttendance extends AttendanceEvent {
  const CreatedAttendance({
    required this.radius,
    required this.status,
  });
  final double radius;
  final String status;
  @override
  List<Object> get props => [radius, status];
}

class Histories extends AttendanceEvent {}
