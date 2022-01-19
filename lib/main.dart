import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/getwords.dart';
import 'package:flutterapp/homepage.dart';


void main() => runApp(HomePage());


class HomePage extends StatelessWidget {

  final _textController = TextEditingController();
  List<RhymeWord>? _rhymeWords;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset('assets/images/output-onlinepngtools (2).png'),
                    margin: EdgeInsets.only(left: 0, top:100, right: 0, bottom:0),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35, top:0, right: 0, bottom:0),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                      child: AnimatedTextKit(
                          repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Rhyme Word Generator', speed: const Duration(milliseconds: 100)),
                        ],
                      ),
                    ),
                  ),


                  Container(
                    child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            hintText: 'Search',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(onPressed: (){
                              _textController.clear();
                            }, icon: Icon(Icons.clear))
                        ),

                        onSubmitted:(value){
                          Services.getRhymeWords(value).then((rhymeWords) {


                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => MyMainPage(words: rhymeWords ))
                            );

                          });


                        }

                    ),
                  )


                ],
              )
            );
          }
        )
    );
  }


}



