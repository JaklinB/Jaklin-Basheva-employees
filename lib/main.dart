import 'package:carousel_slider/carousel_slider.dart';
import 'package:employees/helpers/theme_helper.dart';
import 'package:employees/ui/table.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Text(
                "Welcome to WorkMate",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeHelper.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35),
              child: Text(
                "An application that identifies the pair of employees who have worked together on common projects for the longest period of time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ThemeHelper.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: CarouselSlider.builder(
                itemCount: 100,
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (ctx, index, realIdx) {
                  return Image.asset(
                    "lib/assets/csv_logo.png",
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const Spacer(),
            const Text(
              "You should import a CSV file to start.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeHelper.black,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: ThemeHelper.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TableLayout()),
                );
              },
              icon: const Icon(
                Icons.send,
                size: 24.0,
              ),
              label: const Text("Let's Go", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    ));
  }
}
