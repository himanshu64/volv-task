import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:volv/core/db/shared_prefs.dart';

import 'package:volv/core/viewmodels/base_view_model.dart';
import 'package:volv/ui/views/home_view.dart';
import 'package:volv/ui/views/login_view.dart';

class LoginViewModel extends BaseViewModel {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkUserLoggedIn(BuildContext context) {
    return MySharedPreferences.instance.getBooleanValue('isLoggedIn');
  }

  late String verificationId;
  late String name = '';
  late String email = '';
  late String mobileNumber = '';

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;

    verificationId = '';
    PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      verificationId = verId;
    };
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
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
    return _firebaseAuth
        .signOut()
        .then((value) => MySharedPreferences.instance.removeAll());
  }

  setUserLogged(String name, String email, String phone) {
    MySharedPreferences.instance.setBooleanValue('isLoggedIn', true);
    MySharedPreferences.instance.setStringValue('name', name);
    MySharedPreferences.instance.setStringValue('email', email);
    MySharedPreferences.instance.setStringValue('mobile', phone);
    mobileNumber = phone;
    this.email = email;
    this.name = name;
  }
}
