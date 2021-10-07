import 'package:firebase_auth/firebase_auth.dart';

import 'package:volv/core/viewmodels/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      verificationId = verId;
    };
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            throw exceptio;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      final User? currentUser = _firebaseAuth.currentUser;
      print(user);

      if (currentUser!.uid != "") {
        print(currentUser.uid);
      }
    } catch (e) {
      rethrow;
    }
  }

  void showError(error) {
    throw error.toString();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
