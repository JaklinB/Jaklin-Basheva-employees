import 'package:carousel_slider/carousel_slider.dart';
import 'package:employees/ui/calculation.dart';
import 'package:flutter/material.dart';

import '../helpers/theme_helper.dart';
import 'components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagesList = [
    "lib/assets/csv_logo.png",
    "lib/assets/csv_logo.png",
    "lib/assets/csv_logo.png",
    "lib/assets/csv_logo.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ThemeHelper.backgroundColor,
            ThemeHelper.white,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTitle("Welcome to WorkMate"),
            buildDescription(
                "An application that identifies the pair of employees who have worked together on common projects for the longest period of time."),
            buildImageSlider(imagesList),
            const Spacer(),
            buildInfo("You should import a CSV file to start."),
            const SizedBox(height: 32.0),
            AppButton(
                icon: Icons.send,
                text: "Let's Go",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CalculationScreen()),
                  );
                })
          ],
        ),
      ),
    ));
  }

  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalculationScreen()),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ThemeHelper.white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: ThemeHelper.white,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildImageSlider(List<String> images) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        itemBuilder: (ctx, index, realIdx) {
          return Image.asset(
            images[index],
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }

  Widget buildInfo(String infoText) {
    return Text(
      infoText,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ThemeHelper.black,
        fontSize: 20.0,
      ),
    );
  }
}
