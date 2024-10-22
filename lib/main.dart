import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core
import 'firebase_options.dart';  // Import the generated Firebase options
import 'package:provider/provider.dart';
import 'Provider/provider.dart';
import 'start_screen.dart';  // Your existing screens
import 'organization_registration_screen.dart';
import 'patient_registration_screen.dart';
import 'doctor_diagnosis_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures Flutter is ready before initializing Firebase
  
  // Initialize Firebase with the options based on the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => RegistrationProvider(),
      child: const MyApp(),  // Extracted MaterialApp to a separate widget for better structure
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(),  // Your start screen
    );
  }
}
