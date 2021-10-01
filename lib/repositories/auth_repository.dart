abstract class AuthenticationRepository {
  Future<bool> signIn();
}

class AuthenticationRepositoryIml extends AuthenticationRepository {
  @override
  Future<bool> signIn() async {
    //Fake login action
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
