// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class AttendanceResponse extends Equatable {
  final double radius;
  final String status;
  const AttendanceResponse({
    required this.radius,
    required this.status,
  });
  @override
  List<Object> get props => [radius, status];

  AttendanceResponse copyWith({
    double? radius,
    String? status,
  }) {
    return AttendanceResponse(
      radius: radius ?? this.radius,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radius': radius,
      'status': status,
    };
  }

  factory AttendanceResponse.fromMap(Map<String, dynamic> map) {
    return AttendanceResponse(
      radius: map['radius'] as double,
      status: map['status'] as String,
    );
  }
}

class AttendanceHistoriesResponse extends Equatable {
  final List<Map<String, dynamic>> histories;
  const AttendanceHistoriesResponse({required this.histories});
  List<AttendanceResponse> fromListMap(todos) {
    return todos.map<AttendanceResponse>((e) {
      return AttendanceResponse(
        radius: e['radius'] as double,
        status: e['status'] as String,
      );
    }).toList();
  }

  static List<AttendanceResponse> toListMap(todos) {
    return todos.map<AttendanceResponse>((e) {
      return AttendanceResponse(
        radius: e['radius'] as double,
        status: e['status'] as String,
      );
    }).toList();
  }

  @override
  List<Object?> get props => [histories];
}
