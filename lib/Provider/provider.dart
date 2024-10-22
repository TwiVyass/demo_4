import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication (Optional)

class RegistrationProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance (Optional)

  final List<Map<String, String>> _organizations = [];
  final Map<String, Map<String, String>> _patients = {};
  int _tokenCounter = 1;

  Map<String, Map<String, String>> get patients => _patients;
  List<Map<String, String>> get organizations => _organizations;

  /// Firebase sign in (Optional)
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  /// Add organization and save to Firestore
  Future<void> addOrganization(Map<String, String> organization) async {
    _organizations.add(organization);
    notifyListeners();

    // Save organization to Firestore
    try {
      await _firestore.collection('organizations').add(organization);
    } catch (e) {
      print("Error adding organization to Firestore: $e");
    }
  }

  /// Add a patient, generate token, and save to Firestore
  Future<void> addPatientWithToken(Map<String, String> patientDetails) async {
    final token = 'T$_tokenCounter'; // Generate token
    _tokenCounter++; // Increment token counter
    patientDetails['token'] = token; // Assign token to patient details
    _patients[token] = patientDetails; // Add patient details with token
    notifyListeners();

    // Save patient details to Firestore
    try {
      await _firestore.collection('patients').doc(token).set(patientDetails);
    } catch (e) {
      print("Error adding patient to Firestore: $e");
    }
  }

  /// Retrieve patient from Firestore by token
  Future<Map<String, String>?> getPatientByToken(String token) async {
    try {
      final docSnapshot = await _firestore.collection('patients').doc(token).get();
      if (docSnapshot.exists) {
        return Map<String, String>.from(docSnapshot.data()!); // Return patient details
      }
    } catch (e) {
      print("Error fetching patient by token: $e");
    }
    return null;
  }

  /// Update patient details and sync with Firestore
  Future<void> updatePatientDetails(String token, Map<String, String> updatedDetails) async {
    _patients[token] = updatedDetails;
    notifyListeners();

    // Update patient details in Firestore
    try {
      await _firestore.collection('patients').doc(token).update(updatedDetails);
    } catch (e) {
      print("Error updating patient details in Firestore: $e");
    }
  }
}
