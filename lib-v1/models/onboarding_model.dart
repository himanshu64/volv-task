import 'package:flutter/material.dart';

class OnboardingModel {
  late String title;
  late String image;
  late String description;

  OnboardingModel(
      {required this.title, required this.image, required this.description});
}

List<OnboardingModel> onBoardingList = [
  OnboardingModel(
      title: 'Lorem ipsum',
      image: 'assets/image_one.jpeg',
      description: 'Reference site about Lorem Ipsum '),
  OnboardingModel(
      title: 'Lorem ipsum',
      image: 'assets/image_two.jpeg',
      description: 'Reference site about Lorem Ipsum '),
  OnboardingModel(
      title: 'Lorem ipsum',
      image: 'assets/image_three.jpeg',
      description: 'Reference site about Lorem Ipsum  '),
];
List<LinearGradient> gradientList = [
  const LinearGradient(
      colors: [
        Color(0xFFfceabb),
        Color(0xFFfebbbb),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
  const LinearGradient(
      colors: [
        Color(0xFFeaefb5),
        Color(0xFFfebbbb),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
  const LinearGradient(
      colors: [
        Color(0xFFa7cfdf),
        Color(0xFFfceabb),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp)
];
List<String> imageList = [
  "assets/art.jpeg",
  "assets/art1.jpeg",
  "assets/art2.jpeg",
  "assets/art3.jpeg",
  "assets/art4.jpeg",
  "assets/art5.jpeg"
];
