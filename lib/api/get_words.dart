import 'package:flutterapp/api/data_parsing.dart';
import 'package:http/http.dart' as http;

String apiFullRhyme = 'https://api.datamuse.com/words?rel_rhy=';
String apiSlantRhyme = 'https://api.datamuse.com/words?rel_nry=';
String urlRhyme = '';
String urlSlantRhyme = '';
List<RhymeWord> rhymeWords = [];

class Services {

  static Future<List<RhymeWord>> getRhymeWords(String userInput) async {

    urlRhyme = apiFullRhyme + userInput;
    urlSlantRhyme = apiSlantRhyme + userInput;

    final responseRhyme = await http.get(Uri.parse(urlRhyme));
    final responseSlantRhyme = await http.get(Uri.parse(urlSlantRhyme));

    if ( (responseRhyme.statusCode == 200) && (responseSlantRhyme.statusCode == 200) ) {
      rhymeWords = rhymeWordFromJson(responseRhyme.body);
      rhymeWords += rhymeWordFromJson(responseSlantRhyme.body);
      return rhymeWords;
    } else {
      throw Exception('Failed to load words');
    }
  }
}
