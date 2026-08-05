import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});

final authRoles = StreamProvider<AppUser?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);

  return auth.authStateChanges().asyncMap((user) async {
    if (user == null) return null;

    final token = await user.getIdTokenResult();
    final role = token.claims?['role'] as String?;

    return AppUser(uid: user.uid, role: role);
  });
});

class AppUser {
  final String uid;
  final String? role;

  AppUser({required this.uid, this.role});
}

