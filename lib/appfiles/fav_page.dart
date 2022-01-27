import 'package:flutter/material.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/appfiles/home_page.dart';


class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    var wordBloc = Provider.of<WordBloc>(context);

    return Scaffold(

      body: ListView.builder(
          itemCount: wordBloc.items.length,
          itemBuilder: (context, index){

        return ListTile(
          title: Text(wordBloc.items[index]),
        );
      }),

        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                label: 'Favourite'),
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  icon: const Icon(Icons.home)),
              label: 'Home',
            ),
          ],
        )
    );
  }
}
