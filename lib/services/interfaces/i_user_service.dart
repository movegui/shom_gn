
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/models/user_model.dart';


enum UserRole { admin, user, employe, guest, superAdmin, manager }

abstract class IUserService {
  Future<UserModel?> getByUsername(String username);
  Future<UserModel?> registerWithEmail(BuildContext context, UserModel model, String password);
  Future<void> registerWithPhone(BuildContext context, UserModel model);
  Future<UserModel?> registerWithGoogle(BuildContext context);
  Future<void> registerWithAppleId(UserModel model);
  Future<void> update(UserModel model);
  Future<UserModel?> getByEmail(String email);
  Future<UserModel?> getByPhone(String phone);
  Future<void> signOut();
  Future<UserCredential> verifyOtp(String verificationId,String smsCode);
  Future<void> checkLoginState(String message);
  Future<UserModel?> updateUsername(String value, UserModel? currentUser);
  Future<UserModel?> updateUserEmail(String value, UserModel? currentUser);
  Future<UserModel?> updateUserPhone(String value, UserModel? currentUser);
  Future<void> deleteAccount(BuildContext context);




}