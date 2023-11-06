import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSubmission {
  static bool submitForm({
    required String name,
    required String email,
    required String message,
  }) {
    try {
      FirebaseFirestore.instance.collection('contacts').add({
        'name': name,
        'email': email,
        'message': message,
        'submittedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      return false;
    }
    return true;
  }
}
