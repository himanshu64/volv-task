import 'package:flutter/material.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';
import 'package:volv/ui/views/base_view.dart';
import 'package:volv/ui/views/home_view.dart';
import 'package:volv/ui/views/login_view.dart';

class RootView extends StatelessWidget {
  static const routeArgs = '/';
  const RootView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      model: LoginViewModel(),
      onModelReady: (model){
        
      },
      builder: (context, model, child)=> Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: model.checkUserLoggedIn(context),
          builder: (context, AsyncSnapshot<bool> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!){
                return const HomeView();
              }else{
                return LoginView();
               
              }
              
            }

            return  const Center(
             child: CircularProgressIndicator(),
           );
          }),
      )
      

      
       );
  }
}

// Scaffold(
//         body:
//       ),
//     );