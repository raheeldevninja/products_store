import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthExceptionToMessage(Object e) {
  if(e is FirebaseAuthException) {

    switch(e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'invalid-credential':
        return 'Invalid credentials';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email already in use.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'aborted':
        return 'Sign-in aborted.';
      default:
        return e.message ?? 'Authentication error.';
    }

  }

  return e.toString();
}