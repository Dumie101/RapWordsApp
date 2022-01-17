import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/dataparsing.dart';
import 'package:flutterapp/getwords.dart';


void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  List<RhymeWord>? _rhymeWords;
  bool? _loading;


  @override
  void initState(){
    super.initState();
    _loading = true;
    Services.getRhymeWords().then((rhymeWords) {
      setState(() {
        _rhymeWords = rhymeWords;
        _loading = false;
      });
    });
  }




  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.redAccent),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Center(
                child:
                Text('Rap Words Generator',
                    style:
                    TextStyle(color: Colors.blueAccent)
                )
            ),
        ),

        body: Container(

          color: Colors.white,
          child: ListView.builder(

              itemCount: null == _rhymeWords ? 0 : _rhymeWords!.length,
              itemBuilder: (context, index){


            RhymeWord rhymeWord = _rhymeWords![index];
            return ListTile(
              leading: FlutterLogo(),
              title: Text(rhymeWord.word),
            );


          })



        ),


      )
    );
  }
}
