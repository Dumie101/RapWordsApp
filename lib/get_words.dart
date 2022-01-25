import 'package:flutterapp/data_parsing.dart';
import 'package:http/http.dart' as http;

class Services {

  static Future<List<RhymeWord>> getRhymeWords(String value) async {

    String urlRhyme = 'https://api.datamuse.com/words?rel_rhy=' + value;
    String urlSlantRhyme = 'https://api.datamuse.com/words?rel_nry=' + value;
    final responseRhyme = await http.get(Uri.parse(urlRhyme));
    final responseSlantRhyme = await http.get(Uri.parse(urlSlantRhyme));

    if (200 == (responseRhyme.statusCode) && 200 == responseSlantRhyme.statusCode) {
      List<RhymeWord> rhymeWords = rhymeWordFromJson(responseRhyme.body);
      rhymeWords += rhymeWordFromJson(responseSlantRhyme.body);
      return rhymeWords;
    } else {
      throw Exception('Failed to load words');
    }
  }


}
