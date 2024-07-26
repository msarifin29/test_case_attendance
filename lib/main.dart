import 'package:attendance/presentation/state/location_cubit.dart';
import 'package:attendance/presentation/state/position/position_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection.dart' as di;
import 'injection.dart';
import 'presentation/state/attendance/attendance_bloc.dart';
import 'presentation/state/create_master_location/create_master_location_bloc.dart';
import 'presentation/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  di.sl.allowReassignment = true;
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['BASE_URL'] ?? '',
    anonKey: dotenv.env['API_KEY'] ?? '',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => PositionBloc()),
        BlocProvider(
          create: (context) => CreateMasterLocationBloc(repository: sl()),
        ),
        BlocProvider(create: (context) => AttendanceBloc(repository: sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
