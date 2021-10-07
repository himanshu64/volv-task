import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/verify_view.dart';
import 'package:volv/ui/widgets/custom_button.dart';
import 'package:volv/ui/widgets/custom_full_screen_dialog.dart';
import 'package:volv/ui/widgets/user_text_field.dart';

class LoginView extends StatelessWidget {
  static const routeArgs = '/';

  LoginView({Key? key}) : super(key: key);
  final phoneController = TextEditingController();

  String selectedCountryCode = '+91';

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            icon: const Text('OK!'),
          )
        ],
      ),
    );
  }

  verifyPhone(BuildContext context) {
    try {
      CustomFullScreenDialog.showAlertDialog(context: context);
      Provider.of<LoginViewModel>(context, listen: false)
          .verifyPhone(selectedCountryCode,
              selectedCountryCode + phoneController.text.toString())
          .then((value) {
        CustomFullScreenDialog.cancelDialog(
          context: context,
        );
        Navigator.of(context).pushReplacementNamed(VerifyView.routeArgs,
            arguments: selectedCountryCode + phoneController.text.toString());
      }).catchError((e) {
        CustomFullScreenDialog.cancelDialog(context: context);
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      CustomFullScreenDialog.cancelDialog(context: context);
      _showErrorDialog(context, e.toString());
    }
  }

  void _onCountryChange(CountryCode countryCode) {
    selectedCountryCode = countryCode.toString();
    print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Volv Firebase Phone Auth Task',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Please enter your number below',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )),
                  UserTextField(
                    prefixChild: CountryCodePicker(
                      initialSelection: selectedCountryCode,
                      onChanged: _onCountryChange,
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                    ),
                    titleLabel: 'Enter your number',
                    maxLength: 10,
                    icon: Icons.smartphone,
                    controller: phoneController,
                    inputType: TextInputType.phone,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: CustomButton(
                      title: 'Submit',
                      onpressed: () {
                        if (phoneController.text.isNotEmpty) {
                          verifyPhone(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please enter a phone number',
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
