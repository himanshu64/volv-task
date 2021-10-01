import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volv/controllers/auth/auth_controller.dart';
import 'package:volv/models/onboarding_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          body: AnimatedContainer(
            decoration: BoxDecoration(
              gradient: gradientList[controller.current.value],
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          controller.onPageChanges(index);
                        }),
                    carouselController: controller.buttonCarouselController,
                    items: onBoardingList.map((page) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                              // width: 200,
                              // height: 350.0,
                              child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image.asset(
                                page.image,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                page.title,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                page.description,
                                style: const TextStyle(fontSize: 16.0),
                              )
                            ],
                          ));
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: onBoardingList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => controller.buttonCarouselController
                            .animateToPage(entry.key),
                        child: Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      controller.current.value == entry.key
                                          ? 0.9
                                          : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.loginWithApple();
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150, 48)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0.6)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/apple.png",
                              height: 25.0,
                              width: 25.0,
                            ),
                            const Expanded(
                              child: Text(
                                "Sign in with apple",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.logInWithGoogle();
                        },
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            visualDensity: VisualDensity.comfortable,
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(150, 48)),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white.withOpacity(0.6)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Row(
                          children: [
                            Image.asset("assets/googl.png",
                                height: 25.0, width: 25.0),
                            const Expanded(
                              flex: 2,
                              child: Text("Sign in with google",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 50.0),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't  have an account?  ",
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// 
