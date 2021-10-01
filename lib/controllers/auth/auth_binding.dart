import 'package:get/get.dart';
import 'package:volv/controllers/auth/auth_controller.dart';
import 'package:volv/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
        AuthController(authRepo: AuthenticationRepositoryIml()),
        permanent: true);
  }
}
