import 'package:demo/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/data/questions.dart';

class PatientRegistrationScreen extends StatefulWidget {
  final Map<String, String> organizationData;

  const PatientRegistrationScreen({super.key, required this.organizationData});

  @override
  _PatientRegistrationScreenState createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  String? _selectedOrganization;
  Map<String, String> patientDetails = {};

  String? _selectedBloodGroup;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select organization
            DropdownButton<String>(
              value: _selectedOrganization,
              hint: const Text('Select Organization'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOrganization = newValue;
                });
              },
              items: registrationProvider.organizations.map<DropdownMenuItem<String>>((org) {
                return DropdownMenuItem<String>(
                  value: org['name'],
                  child: Text(org['name'] ?? 'Unknown'),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            // Loop through the questions
            ...questions.map((question) {
              if (question.text == 'Blood Group:') {
                return DropdownButton<String>(
                  value: _selectedBloodGroup,
                  hint: const Text('Select Blood Group'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBloodGroup = newValue;
                      patientDetails[question.text] = newValue!;
                    });
                  },
                  items: question.answers.map<DropdownMenuItem<String>>((answer) {
                    return DropdownMenuItem<String>(
                      value: answer,
                      child: Text(answer),
                    );
                  }).toList(),
                );
              } else if (question.text == 'Gender:') {
                return DropdownButton<String>(
                  value: _selectedGender,
                  hint: const Text('Select Gender'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                      patientDetails[question.text] = newValue!;
                    });
                  },
                  items: question.answers.map<DropdownMenuItem<String>>((answer) {
                    return DropdownMenuItem<String>(
                      value: answer,
                      child: Text(answer),
                    );
                  }).toList(),
                );
              } else if (question.answers.isEmpty) {
                // Show a TextField for questions without predefined answers
                return TextField(
                  decoration: InputDecoration(
                    labelText: question.text,
                  ),
                  onChanged: (value) {
                    patientDetails[question.text] = value;
                  },
                );
              } else {
                return const SizedBox(); // Placeholder for unexpected cases
              }
            }).toList(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_selectedOrganization != null) {
                  // Add patient with token
                  registrationProvider.addPatientWithToken({
                    'organization': _selectedOrganization!,
                    ...patientDetails,  // Merge patient details
                  });
                }
              },
              child: const Text('Register Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
