import 'package:my_notesflutter/repository/repository.dart';


class SupabaseRepository implements IAuthRepository {
  

  @override
  Future<bool> login({required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> register({required String username, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  // TODO: implement token
  String? get token => throw UnimplementedError();

  @override
  // TODO: implement username
  String? get username => throw UnimplementedError();

}







