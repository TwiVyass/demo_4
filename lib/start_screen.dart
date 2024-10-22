import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:demo/Provider/provider.dart'; // Ensure this is used or remove if unnecessary
// ignore: unused_import
import 'package:provider/provider.dart'; // Ensure this is used or remove if unnecessary
import 'patient_registration_screen.dart';
import 'organization_registration_screen.dart';
import 'doctor_diagnosis_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/images/apala-ghar.png', width: 500),
            const SizedBox(height: 80),
            const Text(
              'Choose Your Action!',
              style: TextStyle(
                color: Color.fromARGB(255, 12, 1, 1),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganizationRegistrationScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 10, 0, 0),
              ),
              icon: const Icon(Icons.business),
              label: const Text('Organization Registration'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientRegistrationScreen(
                      organizationData: {}, // Update this if necessary
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 10, 0, 0),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Patient Registration'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDiagnosisScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 10, 0, 0),
              ),
              icon: const Icon(Icons.health_and_safety),
              label: const Text('Doctor Diagnosis'),
            ),
          ],
        ),
      ),
    );
  }
}
