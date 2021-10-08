import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volv/core/viewmodels/home_view_model.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/base_view.dart';
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
    return BaseView<HomeViewModel>(
      onModelReady: (model) async {
        await model.initialise();
      },
      model: HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(model.name),
                  accountEmail: Text(model.email)),
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(model.mobile),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.callApi();
          },
          child: const Icon(Icons.refresh),
        ),
        appBar: AppBar(
          title: Text(
            model.showGreeting() + " " + model.name,
            overflow: TextOverflow.ellipsis,
          ),
          // automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => logOut(context),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: !model.busy
            ? ListView(
                children: [
                  Column(
                    children: [
                      ...List.generate(model.dataList.length, (index) {
                        String key = model.dataList[index].keys.first;
                        return Card(
                          child: ListTile(
                            leading: Text(key),
                            title: Text(model.dataList[index][key]),
                          ),
                        );
                      })
                    ],
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
