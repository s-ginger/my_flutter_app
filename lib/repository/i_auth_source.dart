


abstract interface class IAuthRepository {
  String? get token;
  String? get username;
  Future<bool> register({required String username, required String password});
  Future<bool> login({required String username, required String password});
}




