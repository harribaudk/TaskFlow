import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Authentification locale simple : un compte stocké sur l'appareil.
class LocalAuthService {
  LocalAuthService({SharedPreferences? preferences}) : _preferences = preferences;

  static const String demoEmail = 'demo@taskflow.fr';
  static const String demoPassword = 'demo123';

  static const String _keyEmail = 'auth_email';
  static const String _keyPasswordHash = 'auth_password_hash';
  static const String _keySessionEmail = 'session_email';

  SharedPreferences? _preferences;

  String? _sessionEmail;

  String? get sessionEmail => _sessionEmail;

  bool get isAuthenticated => _sessionEmail != null && _sessionEmail!.isNotEmpty;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
    await _ensureDefaultAccount();
    _sessionEmail = _preferences!.getString(_keySessionEmail);
  }

  Future<bool> login({required String email, required String password}) async {
    final prefs = await _prefs;
    final storedEmail = prefs.getString(_keyEmail);
    final storedHash = prefs.getString(_keyPasswordHash);

    if (storedEmail == null || storedHash == null) {
      return false;
    }

    final normalizedEmail = _normalizeEmail(email);
    if (storedEmail != normalizedEmail || storedHash != _hash(password)) {
      return false;
    }

    await prefs.setString(_keySessionEmail, normalizedEmail);
    _sessionEmail = normalizedEmail;
    return true;
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final prefs = await _prefs;
    final normalizedEmail = _normalizeEmail(email);

    await prefs.setString(_keyEmail, normalizedEmail);
    await prefs.setString(_keyPasswordHash, _hash(password));
    await prefs.setString(_keySessionEmail, normalizedEmail);
    _sessionEmail = normalizedEmail;
    return true;
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_keySessionEmail);
    _sessionEmail = null;
  }

  Future<void> _ensureDefaultAccount() async {
    final prefs = await _prefs;
    if (prefs.containsKey(_keyEmail)) return;

    await prefs.setString(_keyEmail, demoEmail);
    await prefs.setString(_keyPasswordHash, _hash(demoPassword));
  }

  Future<SharedPreferences> get _prefs async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  static String _normalizeEmail(String email) => email.trim().toLowerCase();

  static String _hash(String value) => base64Url.encode(utf8.encode(value));
}
