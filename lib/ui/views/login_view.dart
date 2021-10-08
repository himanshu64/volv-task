import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/base_view.dart';
import 'package:volv/ui/views/verify_view.dart';
import 'package:volv/ui/widgets/custom_button.dart';
import 'package:volv/ui/widgets/custom_full_screen_dialog.dart';
import 'package:volv/ui/widgets/user_text_field.dart';

class LoginView extends StatelessWidget {
  static const routeArgs = '/login-view';

  LoginView({Key? key}) : super(key: key);
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

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
        Navigator.of(context).pushNamed(VerifyView.routeArgs,
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

  final _formState = GlobalKey<FormState>();
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
              child: Form(
                key: _formState,
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
                      titleLabel: 'Enter your name',
                      maxLength: 30,
                      icon: Icons.people,
                      controller: nameController,
                      inputType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        }
                        null;
                      },
                    ),
                    UserTextField(
                      titleLabel: 'Enter your email',
                      maxLength: 25,
                      icon: Icons.email,
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (!isEmail(value!)) {
                          return "enter valid email";
                        }
                        null;
                      },
                    ),
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
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter valid phone number";
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: CustomButton(
                        title: 'Submit',
                        onpressed: () {
                          if (_formState.currentState!.validate()) {
                            Provider.of<LoginViewModel>(context,listen: false).setUserLogged(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                phoneController.text.trim());
                            verifyPhone(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                'Fill All the fields',
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
      ),
    );
  }

  bool isEmail(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }
}
