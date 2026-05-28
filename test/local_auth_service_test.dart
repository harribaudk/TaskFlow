import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/auth/local_auth_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('init crée le compte démo et restaure la session', () async {
    final service = LocalAuthService();
    await service.init();

    final loginOk = await service.login(
      email: LocalAuthService.demoEmail,
      password: LocalAuthService.demoPassword,
    );
    expect(loginOk, isTrue);
    expect(service.isAuthenticated, isTrue);

    final service2 = LocalAuthService();
    await service2.init();
    expect(service2.isAuthenticated, isTrue);
    expect(service2.sessionEmail, LocalAuthService.demoEmail);
  });

  test('login échoue avec de mauvais identifiants', () async {
    final service = LocalAuthService();
    await service.init();

    final loginOk = await service.login(
      email: LocalAuthService.demoEmail,
      password: 'wrong',
    );
    expect(loginOk, isFalse);
    expect(service.isAuthenticated, isFalse);
  });

  test('register remplace le compte local', () async {
    final service = LocalAuthService();
    await service.init();

    await service.register(email: 'user@test.fr', password: 'secret12');
    expect(service.sessionEmail, 'user@test.fr');

    final oldLogin = await service.login(
      email: LocalAuthService.demoEmail,
      password: LocalAuthService.demoPassword,
    );
    expect(oldLogin, isFalse);

    final newLogin = await service.login(
      email: 'user@test.fr',
      password: 'secret12',
    );
    expect(newLogin, isTrue);
  });

  test('logout supprime la session', () async {
    final service = LocalAuthService();
    await service.init();
    await service.login(
      email: LocalAuthService.demoEmail,
      password: LocalAuthService.demoPassword,
    );

    await service.logout();
    expect(service.isAuthenticated, isFalse);
  });
}
