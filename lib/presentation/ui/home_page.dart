import 'dart:developer';

import 'package:attendance/core/geolocator_manager.dart';
import 'package:attendance/presentation/state/create_master_location/create_master_location_bloc.dart';
import 'package:attendance/presentation/state/location_cubit.dart';
import 'package:attendance/presentation/ui/attendance_page.dart';
import 'package:attendance/presentation/ui/history_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double lat = 0.0;
  double long = 0.0;

  @override
  void initState() {
    GeolocatorManager.determinePosition().then((value) {
      context.read<LocationCubit>().currentLocation();
    });
    super.initState();
  }

  void requestStoragePermission() async {
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Request camera permission
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    await availableCameras().then((cameras) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AttendancePage(cameras: cameras, lat: lat, long: long);
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationFailure) {
              showDialog(
                context: context,
                barrierDismissible: false,
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
              lat = state.locationData.latitude;
              long = state.locationData.longitude;
              context
                  .read<CreateMasterLocationBloc>()
                  .add(OnCreated(lat: lat, long: long));
            }
          },
        ),
        BlocListener<CreateMasterLocationBloc, CreateMasterLocationState>(
          listener: (context, state) {
            log('kambing $state');
            if (state is CreateMasterLocationLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Please wait... Create Master Location'),
                      ],
                    ),
                  );
                },
              );
            } else if (state is CreateMasterLocationSuccess) {
              Navigator.pop(context);
            } else if (state is CreateMasterLocationFailure) {
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MapView(lat: lat, long: long);
                      },
                    ),
                  );
                },
                child: const Text('Open Map'),
              ),
              ElevatedButton(
                onPressed: () => requestStoragePermission(),
                child: const Text('Create Attendance'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                },
                child: const Text('Histores Attendances'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
