import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/appfiles/home_page.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(OnBoardingPage(showHome: showHome));
}

class OnBoardingPageBody extends StatefulWidget {
  const OnBoardingPageBody({
    Key? key,
    required this.controller,
    required this.isLastPage,
  }) : super(key: key);

  final PageController controller;
  final bool isLastPage;


  @override
  OnBoardingBody createState() => OnBoardingBody(controller: controller, isLastPage: isLastPage);
}

class OnBoardingPage extends StatefulWidget {
  final bool showHome;

  OnBoardingPage({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Onboarding createState() => Onboarding(showHome: showHome);
}

class Onboarding extends State<OnBoardingPage> {
  final bool showHome;

  Onboarding({required this.showHome});

  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (context) =>
            ChangeNotifierProvider(create: (_) => WordBloc(), child: HomePage())
      },
      home: showHome
          ? ChangeNotifierProvider(create: (_) => WordBloc(), child: HomePage()) : OnBoardingPageBody(controller: controller, isLastPage: isLastPage),
    );
  }
}

class OnBoardingBody extends State<OnBoardingPageBody> {
  OnBoardingBody({
    required this.controller,
    required this.isLastPage,
  });

  PageController controller;
  bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 3;
              });
            },
            children: [
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/Untitled.png',
                  title: "Welcome To The Party",
                  subtitle:
                      "A simple and free application made to search for rhymes. This application was created by @Dumie101. No ads, No payment, No Login."),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/SearchPhoto.png',
                  title: "Search",
                  subtitle:
                      "Use search functionality to look for rhymes and slant rhymes. Click on the word to continue searching. The rhymes and slant rhymes come from the Datamuse API."),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/fav.png',
                  title: "Favourite",
                  subtitle:
                      "Use the favourite feature to save words. Use the star icon to save words. Click on the star icon to view your saved words."),
              buildPage(
                  color1: Colors.lightBlue,
                  color2: Colors.greenAccent,
                  urlImage: 'assets/images/delete.png',
                  title: "Delete",
                  subtitle:
                      "In the favourite page swipe right to delete a saved word. Favourite the word again from the main page to get the word back."),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)
                  ),
                  backgroundColor: Colors.lightBlue,
                  minimumSize: const Size.fromHeight(80)
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.pushNamed(context, '/homepage');
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ))
            : Container(
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
          const SizedBox(height: 62),
          Expanded(
            child: Container(
              color: color1,
              child: Image.asset(
                urlImage,
                alignment: Alignment.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
            height: 200,
            color: color2,
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
