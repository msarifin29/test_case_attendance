// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendance/presentation/state/attendance/attendance_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:attendance/core/helper.dart';
import 'package:attendance/presentation/state/position/position_bloc.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({
    Key? key,
    required this.cameras,
    required this.lat,
    required this.long,
  }) : super(key: key);

  final List<CameraDescription> cameras;
  final double lat;
  final double long;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late CameraController controller;
  XFile? imageFile;
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    initialedCamera();
    context
        .read<PositionBloc>()
        .add(StartPositionStream(lat: widget.lat, long: widget.long));
  }

  void initialedCamera() {
    controller = CameraController(widget.cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> takePicture() async {
    try {
      final XFile picture = await controller.takePicture();
      setState(() {
        imageFile = picture;
      });
    } catch (e) {
      debugPrint('ERROR ${e.toString()}');
    }
  }

  void dialogMsg(String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(msg),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1,
            child: AspectRatio(
              aspectRatio: size.aspectRatio,
              child: OverflowBox(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: size.width,
                    height: size.width * controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: BlocBuilder<PositionBloc, PositionState>(
                builder: (context, state) {
                  if (state is PositionLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is PositionLoaded) {
                    final locationData = state.locationData;
                    double stampLocation = Helper.distanceBetween(
                      state.lat,
                      state.long,
                      locationData.latitude ?? 0.0,
                      locationData.longitude ?? 0.0,
                    );
                    distance = stampLocation;
                    if (distance > 50) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$distance meters',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.red),
                          ),
                          Text(
                            'Your location is out area',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.red),
                          ),
                        ],
                      );
                    }
                    return Text(
                      '$distance meters',
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  } else if (state is PositionError) {
                    return Text(state.message);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<PositionBloc, PositionState>(
              builder: (context, state) {
                if (state is PositionLoading) {
                  return Container(
                    height: 35,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Please wait....'),
                  );
                }
                return BlocListener<AttendanceBloc, AttendanceState>(
                  listener: (context, state) {
                    if (state is CreateAttendanceLoading) {
                    } else if (state is CreateAttendanceFailure) {
                      Navigator.pop(context);
                      dialogMsg('Failed Create Attendance');
                    } else if (state is CreateAttendanceSuccess) {
                      Navigator.pop(context);
                      dialogMsg('Create Attendance Success');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      onTap: distance <= 0
                          ? null
                          : () {
                              context.read<AttendanceBloc>().add(
                                    CreatedAttendance(
                                      radius: distance,
                                      status: distance > 50
                                          ? 'Rejected'
                                          : 'Approved',
                                    ),
                                  );
                            },
                      child: const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.camera_alt, size: 50),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
