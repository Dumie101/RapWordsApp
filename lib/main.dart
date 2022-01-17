import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:datamuse/datamuse.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<List<RhymeWord>> fetchWords() async {
  final response = await http
      .get(Uri.parse('https://api.datamuse.com/words?rel_rhy=forgetful'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final List<RhymeWord> rhymeWords = RhymeWord.fromJson(jsonDecode(response.body));
    return
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



List<RhymeWord> rhymeWordFromJson(String str) => List<RhymeWord>.from(json.decode(str).map((x) => RhymeWord.fromJson(x)));
String rhymeWordToJson(List<RhymeWord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RhymeWord {
  RhymeWord({
    required this.word,
    required this.score,
    required this.numSyllables,
  });

  String word;
  int score;
  int numSyllables;

  factory RhymeWord.fromJson(Map<String, dynamic> json) => RhymeWord(
    word: json["word"],
    score: json["score"],
    numSyllables: json["numSyllables"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "score": score,
    "numSyllables": numSyllables,
  };
}




void main() => runApp(const MyApp());



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late Future<List<RhymeWord>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchWords();
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
      )
    );
  }
}