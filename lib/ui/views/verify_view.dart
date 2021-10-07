import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/home_view.dart';
import 'package:volv/ui/widgets/custom_button.dart';
import 'package:volv/ui/widgets/custom_full_screen_dialog.dart';
import 'package:volv/ui/widgets/user_text_field.dart';

class VerifyView extends StatelessWidget {
  static const routeArgs = '/verify-view';
  final otpController = TextEditingController();

  VerifyView({Key? key}) : super(key: key);

  showSnackBar(msg, color, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          CustomButton(
            onpressed: () {
              Navigator.of(ctx).pop();
            },
            title: 'Ok!',
          )
        ],
      ),
    );
  }

  verifyOTP(BuildContext context) {
    try {
      CustomFullScreenDialog.showAlertDialog(context: context);
      Provider.of<LoginViewModel>(context, listen: false)
          .verifyOTP(otpController.text.toString())
          .then((_) {
        CustomFullScreenDialog.cancelDialog(context: context);

        Navigator.of(context).pushReplacementNamed(HomeView.routeArgs);
      }).catchError((e) {
        CustomFullScreenDialog.cancelDialog(context: context);

        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      CustomFullScreenDialog.cancelDialog(context: context);

      _showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Enter Otp',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Please enter code sent to your number $args',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                UserTextField(
                  titleLabel: 'Enter 6 digit Code',
                  maxLength: 6,
                  icon: Icons.dialpad,
                  controller: otpController,
                  inputType: TextInputType.phone,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    title: 'Verify Code',
                    onpressed: () {
                      if (otpController.text.trim().isNotEmpty) {
                        verifyOTP(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
