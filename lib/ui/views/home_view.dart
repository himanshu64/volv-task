import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/viewmodels/home_view_model.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/login_view.dart';
import 'package:volv/ui/widgets/show_snackbar.dart';

class HomeView extends StatefulWidget {
  static const routeArgs = '/home-view';
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void logOut(BuildContext context) {
    Provider.of<LoginViewModel>(context, listen: false).signOut().then((_) {
      Navigator.of(context).pushReplacementNamed(LoginView.routeArgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () => logOut(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: Text(
          Provider.of<HomeViewModel>(context, listen: false).showGreeting()),
    );
  }
}
