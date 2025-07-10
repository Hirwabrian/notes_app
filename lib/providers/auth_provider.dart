import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<({bool success, String? error})> login(
    String email,
    String password,
  ) async {
    try {
      _setLoading(true);
      final user = await _authService.login(email, password);
      if (user != null) {
        return (success: true, error: null);
      }
      return (success: false, error: "Authentication failed");
    } on FirebaseAuthException catch (e) {
      return (success: false, error: e.message ?? "Authentication error");
    } on Exception catch (e) {
      return (success: false, error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<({bool success, String? error})> signup(
    String email,
    String password,
  ) async {
    try {
      _setLoading(true);
      final user = await _authService.signUp(email, password);
      if (user != null) {
        return (success: true, error: null);
      }
      return (success: false, error: "Signup failed");
    } on FirebaseAuthException catch (e) {
      return (success: false, error: e.message ?? "Signup error");
    } catch (e) {
      return (success: false, error: "An unexpected error occurred");
    } finally {
      _setLoading(false);
    }
  }

  void logout() => _authService.logout();
}
