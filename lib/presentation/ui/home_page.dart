import 'package:attendance/presentation/state/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<LocationCubit, LocationState>(
              listener: (context, state) {
                if (state is LocationFailure) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_outlined, size: 30),
                            SizedBox(height: 20),
                            Text('Please, enabel permission location'),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is LocationSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MapView(
                          lat: state.position.latitude,
                          long: state.position.longitude,
                        );
                      },
                    ),
                  );
                }
              },
              child: ElevatedButton(
                onPressed: () async {
                  context.read<LocationCubit>().currentLocation();
                },
                child: const Text('Open Map'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('Create Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
