import 'package:flutter/material.dart';
import 'package:taskflow/auth/auth_controller.dart';

class AuthScope extends InheritedWidget {
  const AuthScope({
    super.key,
    required this.auth,
    required super.child,
  });

  final AuthController auth;

  static AuthController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthScope>();
    assert(scope != null, 'AuthScope introuvable dans l\'arbre de widgets');
    return scope!.auth;
  }

  @override
  bool updateShouldNotify(AuthScope oldWidget) => auth != oldWidget.auth;
}
