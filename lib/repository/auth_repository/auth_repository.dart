import 'package:my_notesflutter/source/source.dart';

class AuthRepository {
  final IAuthSource authSource;

  String? get token => authSource.token;
  String? get username => authSource.username;

  const AuthRepository({
    required this.authSource
  });

  Future<bool> register({required String username,required String password}) async {
    return await authSource.register(username: username, password: password);
  }

  Future<bool> login({required String username, required String password}) async {
    return await authSource.login(username: username, password: password);
  }
}
