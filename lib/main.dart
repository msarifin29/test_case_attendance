import 'package:attendance/presentation/state/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/ui/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.greenAccent,
            centerTitle: true,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
