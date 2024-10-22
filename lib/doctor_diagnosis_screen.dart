import 'package:flutter/material.dart';
import 'package:demo/Provider/provider.dart';
import 'package:provider/provider.dart'; 
import 'package:demo/data/questions_doctor.dart';

class DoctorDiagnosisScreen extends StatefulWidget {
  @override
  _DoctorDiagnosisScreenState createState() => _DoctorDiagnosisScreenState();
}

class _DoctorDiagnosisScreenState extends State<DoctorDiagnosisScreen> {
  final _tokenController = TextEditingController();
  Map<String, String>? _patientDetails;
  final Map<String, String> _diagnosis = {}; // To hold answers for each question

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Enter Patient Token',
              ),
              onChanged: (value) {
                // Optionally, you can trigger fetching patient details here.
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final token = _tokenController.text;
                if (token.isNotEmpty) {
                  final patientDetails = registrationProvider.patients[token];
                  if (patientDetails != null) {
                    setState(() {
                      _patientDetails = patientDetails;
                    });
                  } else {
                    // Handle the case where the token is not found
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Patient not found.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: const Text('Fetch Patient Details'),
            ),
            const SizedBox(height: 20),
            if (_patientDetails != null) ...[
              // Display patient details
              Text('Organization: ${_patientDetails!['organization']}'),
              Text('Name: ${_patientDetails!['Name:']}'),
              Text('Age: ${_patientDetails!['Age:']}'),
              Text('Weight: ${_patientDetails!['Weight:']}'),
              Text('Blood Group: ${_patientDetails!['Blood Group:']}'),
              Text('Gender: ${_patientDetails!['Gender:']}'),
              // Display the list of questions with text fields for answers
              ..._generateQuestionWidgets(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the diagnosis
                  print('Diagnosis: $_diagnosis');
                  // Optionally, you can also save to a backend or local storage here
                },
                child: const Text('Save Diagnosis'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _generateQuestionWidgets() {
    return questions.map((question) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.text),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter your answer here',
            ),
            onChanged: (value) {
              setState(() {
                _diagnosis[question.text] = value;
              });
            },
          ),
          const SizedBox(height: 16), // Add some space between questions
        ],
      );
    }).toList();
  }
}