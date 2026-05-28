import 'package:flutter/foundation.dart';
import 'package:taskflow/auth/local_auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._authService);

  final LocalAuthService _authService;

  bool _isInitializing = true;
  String? _error;

  bool get isInitializing => _isInitializing;
  bool get isAuthenticated => _authService.isAuthenticated;
  String? get currentEmail => _authService.sessionEmail;
  String? get error => _error;

  Future<void> init() async {
    _isInitializing = true;
    notifyListeners();

    await _authService.init();

    _isInitializing = false;
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _error = null;
    notifyListeners();

    if (email.trim().isEmpty || password.isEmpty) {
      _error = 'Email et mot de passe requis.';
      notifyListeners();
      return false;
    }

    final success = await _authService.login(email: email, password: password);
    if (!success) {
      _error = 'Identifiants incorrects.';
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    _error = null;
    notifyListeners();

    final validationError = _validateRegistration(email, password, confirmPassword);
    if (validationError != null) {
      _error = validationError;
      notifyListeners();
      return false;
    }

    await _authService.register(email: email, password: password);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _error = null;
    await _authService.logout();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  String? _validateRegistration(
    String email,
    String password,
    String confirmPassword,
  ) {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty || !normalized.contains('@')) {
      return 'Veuillez saisir un email valide.';
    }
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères.';
    }
    if (password != confirmPassword) {
      return 'Les mots de passe ne correspondent pas.';
    }
    return null;
  }
}
