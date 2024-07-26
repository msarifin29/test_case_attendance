import 'package:attendance/data/models/attendance_response.dart';
import 'package:attendance/presentation/state/attendance/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<AttendanceBloc>().add(Histories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Histories'),
      ),
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is HistoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoriresFailure) {
            return Center(child: Text(state.msg));
          } else if (state is HistoriesSuccess) {
            List<Map<String, dynamic>> data = state.response.histories;
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No data Attendance History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                  itemCount: state.response.histories.length,
                  itemBuilder: (context, i) {
                    final history = AttendanceHistoriesResponse.toListMap(data);
                    return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Radius : ${history[i].radius} meters',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Status : ${history[i].status}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ));
                  }),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
