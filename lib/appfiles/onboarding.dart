import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/appfiles/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatelessWidget {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            children: [
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/Untitled.png',
                  title: "Welcome To The Party",
                  subtitle:
                      "A simple and free application made to search for rhymes and slant rhymes. Created by Dumie101"),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/SearchPhoto.png',
                  title: "Search",
                  subtitle: "Use search functionality to look for rhymes and slant rhymes. Click on the word to continue searching. The rhymes and slant rhymes come from the Datamuse API"),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/fav.png',
                  title: "Favourite",
                  subtitle: "Use favourite feature to save words. Use the star icon to save words. Click on the star icon to view your saved words"),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/delete.png',
                  title: "Delete",
                  subtitle: "In the fav page swipe right to delete a saved word"),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => controller.jumpToPage(3),
                  child: const Text('SKIP')),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 4,
                ),
              ),
              TextButton(
                  onPressed: () => controller.nextPage(
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeInOut),
                  child: const Text('NEXT'))
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPage({
  required Color color1,
  required Color color2,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: color1,
              child: Image.asset(
                urlImage,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: 20),
            Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            color: color2,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          )
        ],
      ),
    );
