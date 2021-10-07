// import 'dart:convert';
// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:volv/pages/home/home_page.dart';
// import 'package:volv/pages/login/login_page.dart';
// import 'package:volv/repositories/auth_repository.dart';
// import 'package:volv/widgets/custom_full_screen_dialog.dart';

// class AuthController extends GetxController {
//   AuthController({required this.authRepo});
//   late GoogleSignIn googleSign;
//   final AuthenticationRepository authRepo;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final Rxn<User> _firebaseUser = Rxn<User>();

//   User get user => _firebaseUser.value!;

//   var isLoggedIn = false.obs;
//   CarouselController buttonCarouselController = CarouselController();
//   var current = 0.obs;
//   var currentPost = 0.obs;

//   @override
//   void onInit() {
//     _firebaseUser.bindStream(_auth.authStateChanges());
//     ever<User?>(_firebaseUser, handleAuthChanged);
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     googleSign = GoogleSignIn();
//     super.onReady();
//   }

//   logInWithGoogle() async {
//     // final isLoginSuccess = await authRepo.signIn();
//     // isLoggedIn.value = isLoginSuccess;
//     try {
//       CustomFullScreenDialog.showDialog();
//       GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
//       if (googleSignInAccount == null) {
//         CustomFullScreenDialog.cancelDialog();
//       } else {
//         GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//         OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
//             accessToken: googleSignInAuthentication.accessToken,
//             idToken: googleSignInAuthentication.idToken);
//         await _auth.signInWithCredential(oAuthCredential);
//         update();
//         CustomFullScreenDialog.cancelDialog();
//       }
//     } on Exception catch (e) {
//       CustomFullScreenDialog.cancelDialog();
//       print(e.toString());
//       Get.snackbar(
//         "Error signing out",
//         e.toString(),
//       );
//     }
//   }

//   loginWithApple() async {
//     try {
//       CustomFullScreenDialog.showDialog();
//       final rawNonce = generateNonce();
//       final nonce = sha256ofString(rawNonce);

//       // Request credential for the currently signed in Apple account.
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: nonce,
//       );
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         rawNonce: rawNonce,
//       );
//       await _auth.signInWithCredential(oauthCredential);
//     } on Exception catch (e) {
//       CustomFullScreenDialog.cancelDialog();
//       print(e.toString());
//       Get.snackbar(
//         "Error signing out",
//         e.toString(),
//       );
//     }
//   }

//   logout() async {
//     isLoggedIn.value = false;
//     try {
//       await _auth.signOut();
//       update();
//     } on Exception catch (e) {
//       Get.snackbar(
//         "Error signing out",
//         e.toString(),
//       );
//     }
//   }

//   handleAuthChanged(User? user) {
//     print("handleAuthChanged - ${user?.uid}");
//     if (user == null) {
//       Get.offAll(() => const LoginPage());
//     } else {
//       Get.offAll(
//         () => const HomePage(),
//       );
//     }
//   }

//   String generateNonce([int length = 32]) {
//     const charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }

//   /// Returns the sha256 hash of [input] in hex notation.
//   String sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   onPageChanges(int index) {
//     current.value = index;
//     update();
//   }

//   onPostPageChanges(int index) {
//     currentPost.value = index;
//     update();
//   }
// }
