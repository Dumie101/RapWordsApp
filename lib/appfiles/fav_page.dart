import 'package:flutter/material.dart';
import 'package:flutterapp/provider/bookmark_model.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/appfiles/home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late SlidableController slidableController;

  get doNothing => null;

  @override
  Widget build(BuildContext context) {
    var wordBloc = Provider.of<WordBloc>(context);
    bool containsWords = wordBloc.items.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
        body: containsWords
            ? ListView.builder(
                itemCount: wordBloc.items.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue,
                    child: Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          setState(() {
                            wordBloc.removeItems(wordBloc.items[index]);
                          });
                        }),
                        children: [
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(wordBloc.items[index],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  );
                })
            : TextViewForNoWordsSaved(),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  icon: const Icon(Icons.home)),
              label: 'Home',
            ),
          ],
        ));
  }
}

class TextViewForNoWordsSaved extends StatelessWidget {
  const TextViewForNoWordsSaved({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText('No Words Saved.'),
            TyperAnimatedText('Try Again.')
          ],
        ),
      ),
    );
  }
}
