import 'package:abinchan/features/addvehicle/addvehicle.dart';
import 'package:abinchan/features/allvehicles/allvehicles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AddVehicleScreen.routeName: (context) => const AddVehicleScreen(),
        VehicleScreen.routeName: (context) => const VehicleScreen(),
      },
      initialRoute: VehicleScreen.routeName,
    );
  }
}
