// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:volv/controllers/auth/auth_controller.dart';
// import 'package:volv/models/onboarding_model.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final PageController pageController = PageController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (controller) {
//       return Scaffold(
//           key: _scaffoldKey,
//           drawer: Drawer(
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 DrawerHeader(
//                   child: SizedBox(
//                       height: 142,
//                       width: MediaQuery.of(context).size.width,
//                       child: Image.network(
//                         "${controller.user.photoURL}",
//                       )),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     controller.logout();
//                   },
//                   child: const Text(
//                     'LOG OUT',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 45,
//                 ),
//                 Expanded(
//                     child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     height: 65,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.black,
//                     child: const Center(
//                       child: Text(
//                         'v1.0.1',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xffffffff),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ))
//               ],
//             ),
//           ),
//           body: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                         imageList[controller.currentPost.value],
//                       ),
//                     ),
//                   ),
//                   height: MediaQuery.of(context).size.height,
//                 ),
//               ),
//               Positioned(
//                   left: 5,
//                   top: 25.0,
//                   child: IconButton(
//                       onPressed: () => _scaffoldKey.currentState!.openDrawer(),
//                       icon: const Icon(
//                         Icons.menu,
//                         color: Colors.white,
//                         size: 25.0,
//                       ))),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   height: 400.0,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     gradient: LinearGradient(
//                       begin: FractionalOffset.topCenter,
//                       end: FractionalOffset.bottomCenter,
//                       colors: [
//                         Colors.white.withOpacity(0.0),
//                         Colors.white,
//                       ],
//                       stops: const [0.0, 1.0],
//                     ),
//                   ),
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 15.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: PageView.builder(
//                         itemCount: imageList.length,
//                         scrollDirection: Axis.vertical,
//                         controller: pageController,
//                         onPageChanged: (int index) {
//                           controller.onPostPageChanges(index);
//                         },
//                         itemBuilder: (context, int index) => Container(
//                           height: 400.0,
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 10.0,
//                               ),
//                               const Text(
//                                   "Publishing software like Aldus Maker including versions",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       height: 1.5,
//                                       fontSize: 15.0)),
//                               const SizedBox(height: 5.0),
//                               const Text(
//                                 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. The generated Lorem Ipsum is therefore always free from repetition. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)',
//                                 textAlign: TextAlign.justify,
//                                 style: TextStyle(height: 1.5, fontSize: 14.0),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: const [
//                                       Icon(
//                                         Icons.access_time,
//                                         size: 16.0,
//                                         color: Colors.grey,
//                                       ),
//                                       Text(' Today',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                           ))
//                                     ],
//                                   ),
//                                   Text('CHECK IT OUT',
//                                       style: TextStyle(
//                                           color: Colors.yellow[800],
//                                           fontWeight: FontWeight.bold,
//                                           height: 1.5,
//                                           fontSize: 16.0)),
//                                   Row(
//                                     children: const [
//                                       Text(
//                                         ' Share ',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       Icon(
//                                         CupertinoIcons.share,
//                                         size: 16.0,
//                                         color: Colors.grey,
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ));
//     });
//   }
// }
