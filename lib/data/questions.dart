// create questions variables
import 'package:demo/models/patient_questions.dart';

const questions = [
  PatientQuestions(
    'Name:', []
  ),
  PatientQuestions(
    'Age:',[]
  ),
  PatientQuestions(
    'Weight:',[]
  ),
  PatientQuestions(
    'Blood Group:',
    [
      'A+ve',
      'A-ve',
      'B+ve',
      'B-ve',
      'O+ve',
      'O-ve',
      'AB+ve',
      'AB-ve',
    ],
  ),
  PatientQuestions(
    'Gender:',
    [
      'Male',
      'Female',
      'Other',
    ],
  ),
];