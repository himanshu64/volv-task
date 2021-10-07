import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/locator.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/home_view.dart';
import 'package:volv/ui/views/login_view.dart';
import 'package:volv/ui/views/verify_view.dart';
import 'package:volv/ui/widgets/navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocatorInjector.setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginViewModel(),
      child: MaterialApp(
        title: 'volv',
        theme: ThemeData(
            primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch()),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginView.routeArgs,
        navigatorKey: navigatorKey,
        routes: {
          LoginView.routeArgs: (ctx) => LoginView(),
          VerifyView.routeArgs: (ctx) => VerifyView(),
          HomeView.routeArgs: (ctx) => const HomeView(),
        },
      ),
    );
  }
}
