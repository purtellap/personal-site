import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactSubmission {
  static const String _lastSubmitKey = 'lastSubmitKey';

  Future<bool> submitForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      FirebaseFirestore.instance.collection('messages').add({
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

  Future<void> saveSubmissionTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSubmitKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isOnCooldown() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSubmitMillis = prefs.getInt(_lastSubmitKey);
    if (lastSubmitMillis == null) return false;

    final currentTime = DateTime.now();
    final lastSubmitTime =
        DateTime.fromMillisecondsSinceEpoch(lastSubmitMillis);
    final difference = currentTime.difference(lastSubmitTime).inMinutes;

    return difference < 5;
  }
}
